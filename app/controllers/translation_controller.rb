require 'rubygems'
require 'bt'

class TranslationController < ApplicationController
  def getTranslatedText
    bt en zh 'how are you'
    # => "你好吗"

    bt '你为什么这么帅?'
    # => "Why are you so handsome?"

    bt zh kor '你为什么这么帅?'
    # => 너 왜 이렇게 멋있니?
  end
end
