require 'test_helper'

class IndeedServiceReturnsApiResultsTest < ActionDispatch::IntegrationTest

  def setup
    @request = {
      'HTTP_X_FORWARDED_FOR' => nil,
      'HTTP_USER_AGENT' => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/37.0.2062.120 Chrome/37.0.2062.120 Safari/537.36'
    }
  end

  def request
    @indeed_service = IndeedService.new(Rails.application.secrets.indeed_api, @request)
    @indeed_service.execute('Web Developer', 'Family Therapist', 50, '30606')
  end

  test 'should have api secret' do
    assert_not Rails.application.secrets.indeed_api.nil?
  end

  test 'api secret should be invalid' do
    indeed_service = IndeedService.new('wrong', @request)
    assert indeed_service.response.nil?
  end

  test 'should format valid request' do

    request

    assert_not @indeed_service.response['score'].nil?
    assert_not @indeed_service.response['job_total_1'].nil?
    assert_not @indeed_service.response['job_total_2'].nil?
    assert_not @indeed_service.response['job_raw_1'].nil?
    assert_not @indeed_service.response['job_raw_2'].nil?
    assert_not @indeed_service.response['job_listing_1'].nil?
    assert_not @indeed_service.response['job_listing_2'].nil?
  end

  # test 'should properly calculate weighted score' do
  #   indeed_service = IndeedService.new(Rails.application.secrets.indeed_api, @request)
  #   indeed_service.calculate_weighted_score()
  # end

  test 'should properly calculate weighted score' do
    request

    assert_equal 30, @indeed_service.calculate_weight(30)[0]
    assert_equal 70, @indeed_service.calculate_weight(30)[1]

    assert_equal 50, @indeed_service.calculate_weight(50)[0]
    assert_equal 50, @indeed_service.calculate_weight(50)[1]

    assert_equal 10, @indeed_service.calculate_weight(10)[0]
    assert_equal 90, @indeed_service.calculate_weight(10)[1]

    assert_equal 90, @indeed_service.calculate_weight(90)[0]
    assert_equal 10, @indeed_service.calculate_weight(90)[1]
  end

  test 'should properly calculate score' do

    request

    assert_equal 0, @indeed_service.calculate_score(0)
    assert_equal 5, @indeed_service.calculate_score(2)
    assert_equal 10, @indeed_service.calculate_score(7)
    assert_equal 20, @indeed_service.calculate_score(15)
    assert_equal 30, @indeed_service.calculate_score(25)
    assert_equal 40, @indeed_service.calculate_score(45)
    assert_equal 50, @indeed_service.calculate_score(65)
    assert_equal 60, @indeed_service.calculate_score(85)
    assert_equal 80, @indeed_service.calculate_score(105)
    assert_equal 100, @indeed_service.calculate_score(150)
  end

end
