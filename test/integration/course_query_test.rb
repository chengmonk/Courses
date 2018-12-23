require 'test_helper'

class CourseQueryTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    # @user  = users(:michael)
    @user = users(:demo)
    
    # @teacher    = users(:teacherluo)
    # @course1 = courses(:one)
    # @course2 = courses(:two)
    # @course3 = courses(:three)
  end

  test "query course by department" do
    log_in_as(@user)
    get list_courses_url
    # get root_url
    #  assert_template 'courses/list'
    # assert_response 200
    # assert_equal "程子俊",current_user.name
  end

end
