require 'test_helper'

class UserCreatesNewSearchWithApiResultsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:valid)
    # get new_user_session_path
    # post new_user_session_path, user: {
    #   email: @user.email,
    #   password: @user.encrypted_password
    # }
  end

  # test "the truth" do
  #   User.create!(email: @user.email, password: @user.encrypted_password)
  # end
end
