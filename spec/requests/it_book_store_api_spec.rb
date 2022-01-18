require "rails_helper"
require "webmock/rspec"

describe "IT Book Store API", type: :request do
  before do
    WebMock.enable!

    stub_request(:get, "https://api.itbook.store/1.0/search/rails").to_return(
        body: File.read("spec/fixtures/response.json"),
        status: 200,
        headers: { 'Content-Type' => 'application/json' }
    )

    stub_request(:get, "https://api.itbook.store/1.0/books/9780321604811").to_return(
        body: File.read("spec/fixtures/contents.json"),
        status: 200,
        headers: { 'Content-Type' => 'application/json' }
    )

    stub_request(:get, 'http://www.gaitameonline.com/rateaj/getrate').to_return(
        body: File.read("spec/fixtures/getrate.json"),
        status: 200,
        headers: { 'Content-Type' => 'application/json' }
      )
  end

  describe "GET /books/search" do
    context "with valid params" do
      it "return 200" do
      #let(:external_api_response) {
      #  ActiveSupport::JSON.decode(File.read("spec/fixtures/response.json")).to_json
      #}

      #stub_request(:get, "https://api.itbook.store/1.0/search/rails").to_return(
      #  body: external_api_response,
      #  status: 200
      #)

      get '/books/search?search_books_form[keyword]=rails'
      expect(response).to have_http_status(200)
      end
    end
  end
end
