require 'test_helper'

class CourseQueryTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    # @user  = users(:michael)
    @user2 = users(:czj2)

    # @teacher    = users(:teacherluo)
    # @course1 = courses(:one)
    # @course2 = courses(:two)
    # @course3 = courses(:three)
  end


  test "query course by department" do
  	log_in_as(@user2)
    user=current_user
    # assert_equal"123",is_open_student?
    # assert student_logged_in?
    # assert is_open_student?
    # get grades_url( params: {"year_term" => "2018-1"})
    # get "/courses/list"
    #     # assert_response 200
  end

end
