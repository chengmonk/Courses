class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @greeting = "Hi！ "
    @user=user
    mail to: @user.email,
         :subject => '选课系统激活账号'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @greeting = "Hi！ "
    @user=user
    mail to: @user.email,
         :subject => '选课系统重置密码'

  end

  def push_grade(grade)
    @greeting = "Hi！！！ "
    @grade=grade
    mail to: @grade.user.email,
         :subject => '成绩推送'
  end
end
