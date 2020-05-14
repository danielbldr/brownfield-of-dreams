class ActivationController < ApplicationController

  def create
    email_info = { user: current_user }
    ActivationMailer.inform(email_info, current_user.email).deliver_now
    flash[:notice] = "Logged in as #{current_user.first_name}. This account has
                      not yet been activated. Please check your email."
    redirect_to dashboard_path
  end
end
