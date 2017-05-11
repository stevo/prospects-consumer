class Dashboard::TimelineDocumentQuery < Patterns::Query
  queries Document

  private

  def query
    relation.joins(:creator).where(users: { admin: true })
            .joins(:prospect).where(prospects: { target: true })
            .where(document_type: %i[cv team_presentation])
            .where('documents.created_at >= ?', 5.days.ago)
  end
end
