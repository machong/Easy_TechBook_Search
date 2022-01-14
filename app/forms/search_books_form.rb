require 'net/http'
require 'uri'
require 'json'

class SearchBooksForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :keyword, :string

  def query(sorting = 'false')
    if !keyword.empty?
      keyword_mod = keyword.gsub(' ', '+')
      uri = URI.parse(format('https://api.itbook.store/1.0/search/%<x>s', x: keyword_mod))
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Get.new(uri.path)
      res = https.request(req)
      @hash = JSON.parse(res.body)
    elsif sorting[:sorting] == 'true'
      @hash
    else
      @hash = { books: [] }
    end
    self
  end

  def sort(sort_by = 'price', _ascending: true)
    if !@hash['books'].nil? && (sort_by[:sort_by] == 'price')
      if sort_by[:ascending] == 'true'
        @hash['books'].sort_by! { |v| -v['price'] }
      else
        @hash['books'].sort_by! { |v| v['price'] }
      end
    end
    @hash
  end
end
