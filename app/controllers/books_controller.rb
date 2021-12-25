require_relative "../forms/search_books_form.rb"

class BooksController < ApplicationController
  
  def search
    @search_form = SearchBooksForm.new(search_books_params)
  end
  
  private

    def search_books_params
      params.fetch(:q, keyword: '').permit(:keyword)
    end
end
