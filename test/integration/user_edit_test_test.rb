require 'test_helper'

class UserEditTestTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  # test "unsuccessful edit" do
  #   log_in_as(@user)
  #   get edit_user_path(@user)
  #   assert_template 'users/edit'
  #   patch user_path(@user, params: { user: { name:  "",
  #                                            email: "foo@invalid",
  #                                            password:              "foo",
  #                                            password_confirmation: "bar" } })
  #   assert_redirected_to root_url
  # end

  # test "successful edit with friendly forwarding" do
  #   log_in_as(@user)
  #   get edit_user_path(@user)
  #   #   assert_redirected_to edit_user_url(@user)
  #   name  = "Foo Bar"
  #   email = "foo@bar.com"
  #   patch user_path(@user,params: { user: { name:  name,
  #                                           email: email,
  #                                           password:              "",
  #                                           password_confirmation: "" } })
  #   assert_not flash.empty?
  #   assert_redirected_to root_url
  #   @user.reload
  #   assert_equal name,  @user.name
  #   assert_equal email, @user.email
  # end

end
