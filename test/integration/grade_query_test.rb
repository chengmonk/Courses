require 'test_helper'

class GradeQueryTest < ActionDispatch::IntegrationTest
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

  test "query course index no login" do
    get grades_url
    assert_redirected_to root_path
    # assert_response 200
  end

  test "query course index login" do
    log_in_as(@user2)
    get grades_url
    assert_response 200
  end

  test "query course by department" do
  	log_in_as(@user2)
    get grades_url( params: {"year_term" => "2018-1"})
    assert_response 200
  end

end
