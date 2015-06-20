require 'test_helper'

class MeetupTest < ActiveSupport::TestCase

  def setup
    @meetup = meetups(:first_meetup)
  end

  test "score should be present" do
    @meetup.score = nil
    assert_not @meetup.valid?
  end

  test "score should be a number" do
    @meetup.score = 'abc'
    assert_not @meetup.valid?
  end

  test "name should be valid" do
    @meetup.name = nil
    assert_not @meetup.valid?
  end

  test "total groups should be valid" do
    @meetup.total_groups = nil
    assert_not @meetup.valid?
  end

  test "total groups should be a number" do
    @meetup.total_groups = 'abc'
    assert_not @meetup.valid?
  end

  test "total members should be valid" do
    @meetup.total_members = nil
    assert_not @meetup.valid?
  end

  test "total members should be a number" do
    @meetup.total_members = 'abc'
    assert_not @meetup.valid?
  end

end
