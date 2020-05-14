class ActivationMailer < ApplicationMailer
  def inform(email_info, user_email)
    @user_name = email_info[:user][:first_name]
    @user_id = email_info[:user].id
    mail(to: user_email, subject: "#{@user_name} - please activate account")
  end
end
