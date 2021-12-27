# coding: utf-8
require_relative "../forms/search_books_form.rb"

class BooksController < ApplicationController
  
  def search
    @search_form = SearchBooksForm.new(search_books_params)
    @records = @search_form.query()["books"]
  end
  
  private

  def search_books_params
      params.fetch(:search_books_form, keyword: '').permit(:keyword)
    end
end
