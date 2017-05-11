class DashboardController < ApplicationController
  def show
    @prospects = TimelineCollection.new(Document.all)
  end
end
