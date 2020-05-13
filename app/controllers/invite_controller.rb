class InviteController < ApplicationController
  def new

  end

  def create
    sender_name = "#{current_user.first_name} #{current_user.last_name}"
    github_service = GithubService.new
    inform_info = github_service.get_user_info(invite_params[:github_handle], current_user.token)
    if inform_info[:email]
      invitee_email = inform_info[:email]
      InviteMailer.inform(inform_info, invitee_email, sender_name).deliver_now
      flash[:notice] = "Successfully sent invite!"
      redirect_to dashboard_path
    else
      flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
      redirect_to dashboard_path
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:github_handle)
  end
end
