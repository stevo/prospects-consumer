class ProspectsController < ApplicationController
  def index
    @prospects = Prospect.order('id DESC')
  end
end
