class ProspectApiWrapper
  require 'rest-client'
  include Singleton

  BASE_URL = 'http://prospects-api.herokuapp.com/'.freeze
  SUCCESS_CODE = 200

  WrongResponseCodeException = Class.new(StandardError)

  class << self
    delegate :get_prospects, to: :instance
  end

  def get_prospects
    prospects = get('prospects')

    prospects.fetch(:data).map do |prospect_data|
      prospect_data_fetch = prospect_data.fetch(:attributes)
      ApiProspect.new(
        name: prospect_data_fetch.fetch(:name),
        description: prospect_data_fetch.fetch(:description),
        uid: prospect_data.fetch(:id),
        target: calculate_target(prospect_data_fetch.fetch(:country))
      )
    end
  end

  private

  def get(path)
    response = RestClient.get([BASE_URL, path].join, { params: { api_key: ENV.fetch('PROSPECTS_API_KEY') } })

    if success?(response)
      JSON.parse(response.body).with_indifferent_access
    else
      raise WrongResponseCodeException.new(response.code)
    end
  end

  def calculate_target(code)
    market = get("markets/#{code}")
    market.fetch(:population) > 50_000_000 && market.fetch(:growth_potential) == 'high'
  end

  def success?(response)
    response.code == SUCCESS_CODE
  end
end
