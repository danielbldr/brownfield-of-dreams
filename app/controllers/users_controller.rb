class UsersController < ApplicationController
  def show
    @bookmarks = UserVideo.bookmarked_videos
    return unless current_user.token

    github_results = GithubResults.new
    @repos = github_results.get_repos(current_user.token)[0..4]
    @following = github_results.get_following(current_user.token)
    @followers = github_results.get_followers(current_user.token)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to activation_path
    else
      flash[:error] = 'Username already exists'
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    user = User.find(params[:id])
    user.update(active: true)
    user.save
    flash[:success] = 'Thank you! Your account is now activated.'
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
