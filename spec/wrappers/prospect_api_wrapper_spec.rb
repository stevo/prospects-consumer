require 'rails_helper'

RSpec.describe ProspectApiWrapper do
  describe '.get_prospects' do
    it 'returns prospect attributes from API' do
      stub_const 'ProspectApiWrapper::API_KEY', 'abc'

      allow(RestClient).to receive(:get).
        with(
          'http://prospects-api.herokuapp.com/prospects',
          { params: { api_key: 'abc' } }
        ).
        and_return(
          double(
            code: 200,
            body: {
              'data': [
                {
                  'id': '40',
                  'type': 'prospects',
                  'attributes': {
                    'name': 'Captain America',
                    'country': 'jp',
                    'description': 'Needs new shield'
                  },
                  'links': {
                    'self': 'http://prospects-api.herokuapp.com/prospects/40'
                  }
                }
              ]
            }.to_json
          )
        )

      allow(RestClient).to receive(:get).
        with(
          'http://prospects-api.herokuapp.com/markets/jp',
          { params: { api_key: 'abc' } }
        ).
        and_return(
          double(
            code: 200,
            body: {
              'code': 'jp',
              'name': 'Japan',
              'population': 126131985,
              'growth_potential': 'high'
            }.to_json
          )
        )

      result = ProspectApiWrapper.get_prospects

      expect(RestClient).to have_received(:get).
        with(
          'http://prospects-api.herokuapp.com/prospects',
          { params: { api_key: 'abc' } }
        )
      expect(RestClient).to have_received(:get).
        with(
          'http://prospects-api.herokuapp.com/markets/jp',
          { params: { api_key: 'abc' } }
        )

      expect(result).to eq([{
                              name: 'Captain America',
                              description: 'Needs new shield',
                              uid: '40',
                              target: true
                            }])
    end
  end
end
