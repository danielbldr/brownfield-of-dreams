class InviteController < ApplicationController
  def new; end

  def create
    return invite_error unless github_info[:email]

    sender_name = "#{current_user.first_name} #{current_user.last_name}"
    InviteMailer.inform(github_info,
                        github_info[:email],
                        sender_name).deliver_now
    invite_success
  end

  private

  def invite_params
    params.require(:invite).permit(:github_handle)
  end

  def invite_success
    flash[:notice] = 'Successfully sent invite!'
    redirect_to dashboard_path
  end

  def invite_error
    flash[:notice] = "The Github user you selected doesn't have an email
                      address associated with their account."
    redirect_to dashboard_path
  end

  def github_info
    github_service = GithubService.new
    github_service.get_user_info(invite_params[:github_handle],
                                 current_user.token)
  end
end
