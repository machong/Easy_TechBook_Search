require 'net/http'
require 'uri'
require 'json'

class SearchBooksForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :keyword, :string

  def query(sorting = 'false')
    if !keyword.empty?
      # 検索ワードをIT Bookstoreに投げる準備
      keyword_mod = keyword.gsub(' ', '+')
      uri = URI.parse(format('https://api.itbook.store/1.0/search/%<x>s', x: keyword_mod))
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Get.new(uri.path)

      # 検索ワードをIT Booksotreに投げてリクエストを送る回数を調べる
      res = https.request(req)
      @hash = JSON.parse(res.body)
      final_page_num = if @hash['total'].to_i > 1000
                         100
                       else
                         (@hash['total'].to_f / 10).ceil
                       end

      # HTTPリクエストを並列で行う準備
      hydra = Typhoeus::Hydra.hydra

      # IT Bookstoreに並列でHTTPリクエストを送って戻り値を@hashに格納していく
      requests = []
      (2..final_page_num).each do |p|
        request = Typhoeus::Request.new("https://api.itbook.store/1.0/search/#{keyword_mod}/#{p}")
        hydra.queue(request)
        requests.push(request)
      end
      hydra.run
      responses = requests.map do |request|
        request.response.body
      end
      responses.each do |api_res|
        hashed_res = JSON.parse(api_res)
        @hash['books'].push(hashed_res['books'])
        @hash['books'].flatten!
      end
    elsif sorting[:sorting] == 'true'
      @hash
    else
      @hash = { books: [] }
    end
    self
  end

  def sort(sort_by = 'price', _ascending = true)
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
