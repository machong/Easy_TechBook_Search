require 'faraday'
require 'json'
require 'uri'

API_URL = "http://api.fanyi.baidu.com/api/trans/vip/translate"

module BaiduTranslate
  module Translation

    attr_accessor :app_id, :key

    def setup(app_id, key)
      @app_id = app_id
      @key = key
    end

    def translate(text, from, to)
      raise Exception.new("AppID and/or Key missing. Use BaiduTranslate.setup() to initialize.") unless @app_id && @key

      salt = rand(32768..65536)
      api_params = { q: text,
                     from: from,
                     to: to,
                     appid: @app_id,
                     salt: salt,
                     sign: sign(text, salt) }

      response = Faraday.get(API_URL, api_params).body
      parsed_response = JSON.parse(response)
      raise Exception.new(parsed_response.to_s) if parsed_response.key? "error_code"
      parsed_response['trans_result'][0]['dst']
    end

    private
    
    def sign(text, salt)
      undigested_sign = @app_id.to_s + text + salt.to_s + @key
      md5 = Digest::MD5.new
      md5 << undigested_sign
      md5.hexdigest
    end
  end
end
