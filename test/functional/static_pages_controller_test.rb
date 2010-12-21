require "test_helper"

class StaticPagesControllerTest < ActionController::TestCase
   
  test "will render info page" do
    get :info
    assert_response :success
  end
end
