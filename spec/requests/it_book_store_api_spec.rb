require "rails_helper"
require "webmock/rspec"

describe "IT Book Store API", type: :request do
  before do
    WebMock.enable!
  end

  describe "GET /books/search" do
    context "with valid params" do
      it "return 200" do
      let(:external_api_response) {
        ActiveSupport::JSON.decode(File.read("spec/fixtures/response.json")).to_json
      }

      stub_request(:get, "https://api.itbook.store/1.0/search/rails").to_return(
        body: external_api_response,
        status: 200
      )

      get 'https://api.itbook.store/1.0/search/rails'
      expect(response).to have_http_status(200)
      end
    end
  end
end
      
