require 'rails_helper'

RSpec.describe TimelineCollection do
  describe '#each' do
    it 'Display all dates between as empty entries, grouped by customer and descending order' do
      create(:document, title: "document", created_at: "2017-04-01")
      create(:document, title: "document-2", created_at: "2017-04-01")
      create(:document, title: "document-3", created_at: "2017-04-03")

      array = TimelineCollection.new(Document.all)

      arg1 = ["2017-04-01", { "Tony" => ["document", "document-2" ]}]
      arg2 = ["2017-04-02", {}]
      arg3 = ["2017-04-03", { "Tony" => ["document-3" ]}]

      expect { |b| array.each(&b) }.to yield_successive_args(arg1, arg2, arg3)
      expect(TimelineCollection.new(Document.all).count).to eq 3
    end
  end
end
