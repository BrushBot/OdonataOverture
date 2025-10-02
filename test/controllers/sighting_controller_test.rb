require "test_helper"

class SightingControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get sighting_add_url
    assert_response :success
  end
end
