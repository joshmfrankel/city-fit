require 'test_helper'

class IndeedServiceReturnsApiResultsTest < ActionDispatch::IntegrationTest

  def setup
    @request = {
      'HTTP_X_FORWARDED_FOR' => nil,
      'HTTP_USER_AGENT' => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/37.0.2062.120 Chrome/37.0.2062.120 Safari/537.36'
    }
  end

  test 'should have api secret' do
    assert_not Rails.application.secrets.indeed_api.nil?
  end

  test 'should format valid request' do

    indeed_service = IndeedService.new(Rails.application.secrets.indeed_api, @request)
    indeed_service.execute('Web Developer', 'Family Therapist', '30606')

    assert_not indeed_service.response['score'].nil?
    assert_not indeed_service.response['job_total_1'].nil?
    assert_not indeed_service.response['job_total_2'].nil?
    assert_not indeed_service.response['job_raw_1'].nil?
    assert_not indeed_service.response['job_raw_2'].nil?
    assert_not indeed_service.response['job_listing_1'].nil?
    assert_not indeed_service.response['job_listing_2'].nil?
  end

end
