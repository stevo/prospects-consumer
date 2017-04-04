class ProspectApiWrapper
  require 'rest-client'

  API_KEY = 'a2d2142ae77ee3ff86fd6ac644e339d9'.freeze
  BASE_URL = 'http://prospects-api.herokuapp.com/'.freeze
  SUCCESS = 200

  def self.get_prospects
    prospects = get('prospects')

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

  def self.get(path)
    response = RestClient.get([BASE_URL, path].join, { params: { api_key: API_KEY } })

    if success?(response)
      JSON.parse(response.body).with_indifferent_access
    else
      raise WrongResponseCodeError.new(response.code)
    end
  end

  def self.calculate_target(code)
    market = get("markets/#{code}")
    market.fetch(:population) > 50_000_000 && market.fetch(:growth_potential) == 'high'
  end

  def self.success?(response)
    response.code == SUCCESS
  end

  private_class_method :get, :calculate_target, :success?

  class WrongResponseCodeError < StandardError
    def initialize(code)
      super("Wrong response code: #{code}")
    end
  end
end
