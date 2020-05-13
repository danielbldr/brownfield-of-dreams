class FriendsController < ApplicationController
  def create
    friend = User.where(github_login: params[:friend])
    current_user.friended << friend
    redirect_to dashboard_path
  end
end
