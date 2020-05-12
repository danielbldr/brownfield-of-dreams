class GithubController < ApplicationController
  def create
    token = auth_info['credentials']['token']
    current_user.update(token: token, github_login: get_user_login(token))
    redirect_to dashboard_path
  end

  protected

  def auth_info
    request.env['omniauth.auth']
  end

  def get_user_login(token)
    github = GithubService.new
    github.user_repos(token).first[:owner][:login]
  end
end
