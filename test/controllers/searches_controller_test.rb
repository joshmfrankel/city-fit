require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user   = users(:john)
    sign_in @user
    #@search = @user.searches.build(job1: "Web Developer", job2: "Marriage and Family Therapist", location: "Athens, Ga")
    @search = searches(:one)
  end

  test "should be valid" do
    assert @search.valid?
  end

  test "should have valid user id" do
    @search.user_id = nil
    assert_not @search.valid?
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show search" do
    get :show, id: @search
    assert_response :success
  end

  test "should create search" do

    assert_difference 'Search.count' do
      post :create, search: {
        job1: @search.job1,
        job2: @search.job2,
        location: @search.location,
        user_id: @search.user_id
      }
    end

    assert_redirected_to indeed_results_path
  end

  test "should not create search when location empty" do
    @search.location = nil
    assert_no_difference 'Search.count' do
      post :create, search: {
        job1: @search.job1,
        job2: @search.job2,
        location: @search.location,
        user_id: @search.user_id
      }
    end

    assert_template 'new'
  end

end
