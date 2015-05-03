require 'test_helper'

class IndeedResultTest < ActiveSupport::TestCase

  def setup
    @indeed_result = indeed_result(:one)
  end

  test "score should be present" do
    @indeed_result.score = nil
    assert_not @indeed_result.valid?
  end

  test "job total 1 should be present" do
    @indeed_result.job_total_1 = nil
    assert_not @indeed_result.valid?
  end

  test "job total 2 should be present" do
    @indeed_result.job_total_2 = nil
    assert_not @indeed_result.valid?
  end

  test "job listing 1 should be present" do
    @indeed_result.job_listing_1 = nil
    assert_not @indeed_result.valid?
  end

  test "job listing 2 should be present" do
    @indeed_result.job_listing_2 = nil
    assert_not @indeed_result.valid?
  end

  test "job raw 1 should be present" do
    @indeed_result.job_raw_1 = nil
    assert_not @indeed_result.valid?
  end

  test "job raw 2 should be present" do
    @indeed_result.job_raw_2 = nil
    assert_not @indeed_result.valid?
  end

end
