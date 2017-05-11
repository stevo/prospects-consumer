require 'rails_helper'

RSpec.describe Dashboard::TimelineDocumentQuery do
  describe '.call' do
    let(:admin) { create(:user, :admin) }
    let(:expected_document) { create(:document, :cv, creator: admin, prospect: create(:prospect, target: true)) }
    let(:not_expected_document) { expected_document }

    it 'Only documents added by administrators in last 5 days for target prospects with only CVs and team presentation' do
      expect(Dashboard::TimelineDocumentQuery.call).to match_array([expected_document])
    end

    context 'filters' do
      it 'Only documents added by administrators' do
        not_expected_document.update(creator: create(:user))

        expect(Dashboard::TimelineDocumentQuery.call).not_to match_array([not_expected_document])
      end

      it 'Only documents created in last 5 days' do
        not_expected_document.update(created_at: 1.year.ago)

        expect(Dashboard::TimelineDocumentQuery.call).not_to match_array([not_expected_document])
      end

      it 'Only documents for target prospects' do
        not_expected_document.prospect.update(target: false)

        expect(Dashboard::TimelineDocumentQuery.call).not_to match_array([not_expected_document])
      end

      it 'Only CVs and team presentation' do
        not_expected_document.update(document_type: :project_overview)

        expect(Dashboard::TimelineDocumentQuery.call).not_to match_array([not_expected_document])
      end
    end
  end
end
