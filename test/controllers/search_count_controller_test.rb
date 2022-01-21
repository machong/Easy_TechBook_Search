require "test_helper"

class SearchCountControllerTest < ActionDispatch::IntegrationTest
  test "should get save" do
    get search_count_save_url
    assert_response :success
  end
end
