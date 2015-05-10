require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user   = users(:john)
    sign_in @user
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

  test "should get edit" do
    get :edit, id: @search.id
    assert_response :success
  end

  test "should show search" do
    get :show, id: @search.id
    assert_response :success
  end

  test "should create search" do

    assert_difference 'Search.count' do
      post :create, search: {
        job1: @search.job1,
        job2: @search.job2,
        job_scale: @search.job_scale,
        location: @search.location
      }
    end

    assert_redirected_to search_path(assigns(:search))
  end

  test "should not create search when location empty" do
    @search.location = nil
    assert_no_difference 'Search.count' do
      post :create, search: {
        job1: @search.job1,
        job2: @search.job2,
        job_scale: @search.job_scale,
        location: @search.location
      }
    end

    assert_template 'new'
  end

  test "should update search" do
    patch :update, id: @search, search: {
      job1: @search.job1,
      job2: @search.job2,
      job_scale: @search.job_scale,
      location: @search.location
    }
    assert_redirected_to search_path(assigns(:search))
  end

  test "should destroy search" do
    assert_difference 'Search.count', -1 do
      delete :destroy, id: @search
    end
    assert_redirected_to searches_path
  end

end
