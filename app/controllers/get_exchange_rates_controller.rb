class GetExchangeRatesController < ApplicationController
  require 'open-uri'
  require 'json'
# rubocop:disable all
  def getRate
    html = open('http://www.gaitameonline.com/rateaj/getrate').read
    json = JSON.parse(html)['quotes']
    usdjpy =json[20]['open']
    puts "USDJPY:#{usdjpy}"
    usdjpy
  end
# rubocop:enable all
end
