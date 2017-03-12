class ProspectsController < ApplicationController
  def index
    @prospects = Prospect.all
  end
end
