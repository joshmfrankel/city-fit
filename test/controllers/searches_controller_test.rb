require 'test_helper'

class SearchesControllerTest < ActionController::TestCase

  def setup
    @user = users(:john)
  end

  test "should get new" do
    get :new
    assert_response :success
  end
end
