require 'test_helper'

class MeetupApiReturnsResultsTest < ActionDispatch::IntegrationTest

  def request
    @meetup_interests = MeetupService.new('Camping, Hiking, Software Development, Dancing', 30606)
  end

  test 'should have proper input' do
    request

    assert_not @meetup_interests.nil?
  end

  test 'should have api key' do
    assert_not Rails.application.secrets.meetup_api.nil?
  end

  # test 'should not allow invalid keys' do
  #   Rails.application.secrets.meetup_api = 'invalid'
  #   request
  #   assert @meetup_interests.execute.nil?
  # end

  test 'should have a valid response' do
    request

    @meetup_interests.execute
  end

  # test 'should be invalid request' do
  #   request

  #   # Set api key to nil
  #   @meetup_interests.execute
  # end

  # test 'should be valid request' do
  #   request

  #   @meetup_interests.execute
  # end
end
