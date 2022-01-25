require 'rails_helper'

RSpec.describe 'get_exchange_rates', type: :request do
  before do
    WebMock.disable!
  end
  describe 'GET /get_exchange_rates/getRate' do
    it 'リクエストが成功すること' do
      get '/get_exchange_rates/getRate'
      expect(response).to have_http_status(200)
    end
  end
end
