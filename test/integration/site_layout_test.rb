require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  # Integration login
  def login
    post '/users/sign_in', 'user[email]' => 'joshmfrankel@gmail.com', 'user[password]' => '23monkey'
  end

  test 'search form should have proper elements' do
    login
    get new_search_path
    assert_template 'searches/new'
    assert_select 'input[name=?]', 'search[job1]'
    assert_select 'input[name=?]', 'search[job2]'
    assert_select 'input[name=?]', 'search[job_scale]'
    assert_select 'input[name=?]', 'search[location]'
    assert_select 'input[name=?]', 'search[meetup_interest]'
  end
end
