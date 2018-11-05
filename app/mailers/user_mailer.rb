class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  default from : "from@example.com"
  def account_activation(user)
    @user = user
    mail to: user.email, subject:"Account activation"
end
end
