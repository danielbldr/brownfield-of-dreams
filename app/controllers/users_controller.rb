class UsersController < ApplicationController
  def show
    conn = Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{current_user.token}"
    end

    response = conn.get('user/repos')
    json = JSON.parse(response.body, symbolize_names: true)

    @repos = []
    5.times do |repo|
      @repos << json[repo]
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
