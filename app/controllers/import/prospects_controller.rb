module Import
  class ProspectsController < ApplicationController
    include ActionView::Helpers::TextHelper

    def create
      prospects = ProspectApiWrapper.instance.get_prospects
      created_prospects = Prospect.create(prospects.reverse)
      size = created_prospects.select(&:id).count

      flash[:notice] = "#{pluralize(size, 'new prospect')} #{'was'.pluralize(size)} imported"

      redirect_to prospects_path
    end
  end
end
