class GetExchangeRatesController < ApplicationController
  require 'open-uri'
  require 'json'
  def getRate
    html = open('http://www.gaitameonline.com/rateaj/getrate').read
    json = JSON.parse(html)['quotes']
    json.each do |data|
      puts "通貨:#{data['currencyPairCode']} 最高値:#{data['high']} 最安値:#{data['low']} ASK:#{data['ask']} BID:#{data['bid']} 開始値:#{data['open']}"
    end
  end
end
