class GetExchangeRatesController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  def getRate
    uri = URI.parse('http://www.gaitameonline.com/rateaj/getrate')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.path)
    res = http.request(req)
    @result = JSON.parse(res.body)['quotes']
  end
end
