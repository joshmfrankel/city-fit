require 'test_helper'
include Devise::TestHelpers

class SearchTest < ActiveSupport::TestCase

  def setup
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
