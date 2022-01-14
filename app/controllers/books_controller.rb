require_relative '../forms/search_books_form'
require_relative './get_exchange_rates_controller'
require 'net/http'
require 'uri'
require 'json'

class BooksController < ApplicationController
  def search
    if params[:sorting].nil?
      @search_form = SearchBooksForm.new(search_books_params)
      session[:search_params] = search_books_params
    else
      @search_form = SearchBooksForm.new(session[:search_params])
    end
    # IT BookstoreからのJSON戻り値を@recordsに格納する
    @records = if params[:sort_by].nil?
                 @search_form.query(sorting: 'false').sort(sort_by: 'price', ascending: 'true')['books']
               else
                 @search_form.query(sorting: params[:sorting]).sort(sort_by: params[:sort_by],
                                                                    ascending: params[:ascending])['books']
               end

    # IT Bookstoreのサーバが落ちている時は↑の@records行をコメントアウトして↓のダミーデータを使う
    #
    #     @records = [
    #       {
    #         "title"    => "Practical MongoDB",
    #         "subtitle" => "Architecting, Developing, and Administering MongoDB",
    #         "isbn13"   => "9781484206485",
    #         "price"    => "$0.0",
    #         "image"    => "https://itbook.store/img/books/9781484206485.png",
    #         "url"      => "https://itbook.store/books/9781484206485"
    #       },
    #       {
    #         "title"    => "The Definitive Guide to MongoDB, 3rd Edition",
    #         "subtitle" => "A complete guide to dealing with Big Data using MongoDB",
    #         "isbn13"   => "9781484211830",
    #         "price"    => "$47.11",
    #         "image"    => "https://itbook.store/img/books/9781484211830.png",
    #         "url"      => "https://itbook.store/books/9781484211830"
    #       }
    #     ]

    # IT BookstoreからのJSON戻り値(詳細版)を@detailed_recordsに格納する
    @detailed_records = []
    @records&.each do |book|
      uri = URI.parse("https://api.itbook.store/1.0/books/#{book['isbn13']}")
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Get.new(uri.path)
      res = https.request(req)
      @detailed_records.push(JSON.parse(res.body))
    end

    # 現時点でのドル円レートを取得
    # rate = GetExchangeRatesController.new
    # yen_rate = rate.getRate

    # @detailed_recordsのpriceの値を文字列から数字にした上で円換算
    @detailed_records&.each do |detailed_book|
      detailed_book['price'] = detailed_book['price'][1..].to_f
      # detailed_book["price"] *= yen_rate
      detailed_book['price'] *= 114 # 今はダミーでドル円レートを114にしている
      detailed_book['price'] = detailed_book['price'].ceil
    end

    # @detailed_recordsを安い順にソート
    @detailed_records.sort_by! { |a| a['price'] }
  end

  private

  def search_books_params
    params.fetch(:search_books_form, keyword: '').permit(:keyword)
  end
end
