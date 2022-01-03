# coding: utf-8
require_relative "../forms/search_books_form.rb"

class BooksController < ApplicationController
  
  def search
    @search_form = SearchBooksForm.new(search_books_params)
    debugger
    #@records = @search_form.query()["books"]
    unless params[:sort_by].nil? then
      @records = @search_form.query().sort(sort_by: params[:sort_by], ascending: params[:ascending])["books"]
    else      
      @records = @search_form.query().sort()["books"]
    end
  end
  
  private

  def search_books_params
      params.fetch(:search_books_form, keyword: '').permit(:keyword)
    end
end
