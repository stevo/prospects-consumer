module Import
  class ProspectsController < ApplicationController
    include ActionView::Helpers::TextHelper

    def create
      prospects = ProspectApiWrapper.get_prospects

      size = 0
      prospects.reverse.each do |prospect|
        new_prospect = Prospect.create(prospect.attributes)
        size += 1 if new_prospect.persisted?
      end

      flash[:notice] = I18n.translate :new_prospect_was_imported, count: size

      redirect_to prospects_path
    end
  end
end
