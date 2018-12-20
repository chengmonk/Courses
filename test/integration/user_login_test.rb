require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:czj)
    @teacher = users(:teacherluo)
  end

  test 'login with valid information' do
    get sessions_login_path
    post sessions_login_path(params: { session: {email: @user.email, :password => 'password'} })
    assert_redirected_to controller: :homes, action: :index
    follow_redirect!
    assert_template 'homes/index'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', rails_admin_path, count: 0
  end

  test "login with valid information by student" do
    get sessions_login_path
    post sessions_login_path(params: {session: {email: @user.email, password: 'password'}})
    assert_redirected_to controller: :homes, action: :index
    follow_redirect!
    assert_template 'homes/index'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", sessions_logout_path, count: 0
    assert_select "a[href=?]", courses_path, count: 0
  end

  test "login with valid information by teacher" do
    get sessions_login_path
    post sessions_login_path(params: {session: {email: @teacher.email, password: 'password'}})
    assert_redirected_to controller: :homes, action: :index
    follow_redirect!
    assert_template 'homes/index'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", sessions_logout_path, count: 0
    assert_select "a[href=?]", courses_path, count: 0
  end

  test "login with valid information followed by logout" do
    get sessions_login_path
    post sessions_login_path(params: {session: {email: @teacher.email, password: 'password'}})
    assert_redirected_to controller: :homes, action: :index
    follow_redirect!
    assert_template 'homes/index'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", sessions_logout_path, count: 0
    assert_select "a[href=?]", courses_path, count: 0
    delete sessions_logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window.
    delete sessions_logout_path
    follow_redirect!
    assert_select "a[href=?]", sessions_login_path
    assert_select "a[href=?]", sessions_logout_path,      count: 0
  end
end
