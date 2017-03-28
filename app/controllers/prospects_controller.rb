class ProspectsController < ApplicationController
  def index
    @prospects = Prospect.order(id: :desc)
  end
end
