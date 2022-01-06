require 'test_helper'

class GetExchangeRatesControllerTest < ActionDispatch::IntegrationTest
  test 'should get getRate' do
    get get_exchange_rates_getRate_url
    assert_response :success
  end
end
