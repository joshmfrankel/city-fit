require 'test_helper'

class UserCreatesNewSearchWithApiResultsTest < ActionDispatch::IntegrationTest

  def setup

  end

  test "should login and save search api results" do

    # login
    post '/users/sign_in', 'user[email]' => 'joshmfrankel@gmail.com', 'user[password]' => '23monkey'
    assert_redirected_to root_path

    # Check for multiple table changing
    assert_difference ['Search.count', 'IndeedResult.count'] do
      post '/searches', 'search[job1]' => 'Web Developer', 'search[job2]' => 'Clinical Therapist', 'search[location]' => '30606'
    end

  end

  test "should not save search api results when not logged in" do
    # Check for multiple table changing
    assert_no_difference ['Search.count', 'IndeedResult.count'] do
      post '/searches', 'search[job1]' => 'Web Developer', 'search[job2]' => 'Clinical Therapist', 'search[location]' => '30606'
    end
  end
end
