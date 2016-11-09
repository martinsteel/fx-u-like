require 'test_helper'

class FxControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fx_index_url
    assert_response :success
  end

end
