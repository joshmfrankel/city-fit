require 'test_helper'
include Devise::TestHelpers

class SearchTest < ActiveSupport::TestCase

  def setup
    #@user = users(:john)
    #@search = @user.searches.build(job1: 'Web Developer', job2: 'Doctor', location: '30606')
    #@user   = users(:john)
    #sign_in @user
    @search = searches(:one)
  end

  test "user id should be present" do
    @search.user_id = nil
    assert_not @search.valid?
  end

  test "job 1 should be present" do
    @search.job1 = nil
    assert_not @search.valid?
  end

  test "job 2 should be present" do
    @search.job2 = nil
    assert_not @search.valid?
  end

  test "location should be present" do
    @search.location = nil
    assert_not @search.valid?
  end

end
