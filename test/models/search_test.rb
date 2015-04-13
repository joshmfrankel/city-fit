require 'test_helper'

class SearchTest < ActiveSupport::TestCase

  def setup
    @user = users(:john)
    @search = @user.searches.build(job1: 'Web Developer', job2: 'Doctor', location: '30606')
  end

  test "user id should be present" do
    @search.user_id = nil
    assert_not @search.valid?
  end

end
