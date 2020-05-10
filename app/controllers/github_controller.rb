class GithubController < ApplicationController
  def create
    token = auth_info['credentials']['token']
    current_user.update_attribute(:token, token)
    redirect_to dashboard_path
  end

  protected

  def auth_info
    request.env['omniauth.auth']
  end
end
