require 'test_helper'

class ChooseCoursesTestTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user       = users(:michael)
    @user2     =users(:czj)
    @teacher    = users(:teacherluo)
    @course1 = courses(:one)
    @course2 = courses(:two)
    @course3 = courses(:three)
  end

  test "test choose course" do
    log_in_as(@user)
    get select_path(@course2)
    assert_redirected_to root_path
    assert_not flash.empty?
  end
end
