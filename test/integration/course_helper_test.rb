require 'test_helper'
include CourseHelper
include SessionsHelper
class CourseHelperTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  # def setup
  #   @user       = users(:michael)
  #   @user2     =users(:czj)
  #   @teacher    = users(:teacherluo)
  #   @course1 = courses(:one)
  #   @course2 = courses(:two)
  #   @course3 = courses(:three)
  # end

  # test "convert original semester to integrated semester " do
  #   assert_equal "2018-2019学年（秋季）第一学期", integrated_semester("2018-1")
  # end

  # test "not in select course time for student" do 
  # 	assert_not is_open_student?
  # end

  # test "in add course time for teacher" do 
  # 	assert_not is_open_teacher?
  # end

end
