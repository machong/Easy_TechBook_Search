require 'net/http'
require 'uri'
require 'json'

class SearchBooksForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :keyword, :string

  def query()
    if !self.keyword.empty? then
      keyword_mod = self.keyword.gsub(' ', '+')
      uri = URI.parse(format('https://api.itbook.store/1.0/search/%<x>s', x: keyword_mod))
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Get.new(uri.path)
      res = https.request(req)
      @hash = JSON.parse(res.body)
    elsif
      @hash = {books:[]}
    end
    return self
  end

  def sort(sort_by='price', ascending = true)
    unless @hash["books"].nil? then
      if sort_by == "price" then
        if ascending == true then
          @hash["books"].sort_by!{|v| v["price"]}
        else
          @hash["books"].sort_by!{|v| -v["price"]}
        end
      end
    end
    return @hash
  end
end
