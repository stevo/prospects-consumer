class ProspectApiWrapper
  require 'rest-client'

  API_KEY = 'a2d2142ae77ee3ff86fd6ac644e339d9'.freeze
  BASE_URL = 'http://prospects-api.herokuapp.com/'.freeze
  SUCCESS = 200

  def self.get_prospects
    response = get('prospects')

    if success?(response)
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

  def self.get(url)
    RestClient.get [BASE_URL, url].join, { params: { api_key: API_KEY } }
  end

  def self.calculate_target(code)
    response = get("markets/#{code}")

    if success?(response)
      market = JSON.parse(response.body).symbolize_keys

      market.fetch(:population) > 50_000_000 && market.fetch(:growth_potential) == 'high'
    end
  end

  def self.success?(response)
    response.code == SUCCESS
  end
end
