require_relative '../forms/search_books_form'
require 'net/http'
require 'uri'
require 'json'

class BooksController < ApplicationController
  def search
    @search_form = SearchBooksForm.new(search_books_params)

    # IT BookstoreからのJSON戻り値を@recordsに格納する
    unless params[:sort_by].nil? then
      @records = @search_form.query().sort(sort_by: params[:sort_by], ascending: params[:ascending])["books"]
    else      
      @records = @search_form.query().sort()["books"]
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
    @records.each do |book|
      uri = URI.parse('https://api.itbook.store/1.0/books/' + book["isbn13"])
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Get.new(uri.path)
      res = https.request(req)
      @detailed_records.push(JSON.parse(res.body))
    end

  end



  private

  def search_books_params
    params.fetch(:search_books_form, keyword: '').permit(:keyword)
  end
end
