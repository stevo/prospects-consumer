class TimelineCollection
  include Enumerable

  def initialize(relation)
    @relation = relation
  end

  def each(&block)
    items.map { |item| yield(item) }
  end

  private

  def items
    (min_date.to_date..max_date.to_date).map do |date|
      [date.to_s, author_documents(date).first || {}]
    end
  end

  def dates_group
    @relation.select(:created_at).group(:created_at).to_a
  end

  def max_date
    dates_group.last.created_at.to_date
  end

  def min_date
    dates_group.first.created_at.to_date
  end

  def author_documents(date)
    @relation.select { |document| document.created_at.to_date == date }
             .group_by { |r| r.prospect.name }
             .each_pair
             .map { |author, values| { author => values.map(&:title)} }
  end
end
