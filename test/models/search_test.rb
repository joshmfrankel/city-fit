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

  test "job_scale should be present" do
    @search.job_scale = nil
    assert_not @search.valid?
  end

  test "job_scale should be valid" do
    @search.job_scale = -20
    assert @search.valid?
  end

  test "job_scale should not be less than -50" do
    @search.job_scale = -51
    assert_not @search.valid?
  end

  test "job_scale should not be greater than 50" do
    @search.job_scale = 51
    assert_not @search.valid?
  end

end
