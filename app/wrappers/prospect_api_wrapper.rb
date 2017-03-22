class ProspectApiWrapper
  require 'rest-client'

  API_KEY = 'a2d2142ae77ee3ff86fd6ac644e339d9'

  def self.get_prospects
    response = RestClient.get 'http://prospects-api.herokuapp.com/prospects',
                              { params: { api_key: API_KEY } }

    if response.code == 200
      prospects = JSON.parse(response.body).with_indifferent_access

      prospects.fetch(:data).map do |prospect_data|
        prospect_data_fetch = prospect_data.fetch(:attributes)
        {
          name: prospect_data_fetch.fetch(:name),
          description: prospect_data_fetch.fetch(:description),
          uid: prospect_data.fetch(:id),
          target: calculate_target(prospect_data_fetch.fetch(:country))
        }
      end
    end
  end

  private_class_method

  def self.calculate_target(code)
    response = RestClient.get "http://prospects-api.herokuapp.com/markets/#{code}",
                              { params: { api_key: API_KEY } }

    if response.code == 200
      market = JSON.parse(response.body).with_indifferent_access

      market.fetch(:population) > 50_000_000 && market.fetch(:growth_potential) == 'high'
    end
  end
end
