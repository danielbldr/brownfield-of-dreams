class GithubController < ApplicationController
  def create
    token = auth_info['credentials']['token']
    current_user.update(token: token, github_login: user_login(token))
    redirect_to dashboard_url
  end

  protected

  def auth_info
    request.env['omniauth.auth']
  end

  def user_login(token)
    GithubService.new.github_login(token)
  end
end
