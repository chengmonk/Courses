require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = users(:czj)
  end

  test "active" do
    email = UserMailer.account_activation(@user)
    assert_emails 1 do
      email.deliver_now
    end
    assert_equal [@user.email], email.to
    assert_equal '选课系统激活账号', email.subject
  end

  test "password_reset" do
    email = UserMailer.password_reset(@user)
    assert_emails 1 do
      email.deliver_now
    end
    assert_equal [@user.email], email.to
    assert_equal '选课系统重置密码', email.subject
  end

end
