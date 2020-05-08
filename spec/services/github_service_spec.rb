require 'rails_helper'

describe 'GithubService', type: :service do
  before(:each) do
    @user = User.create(email: "mike@mike.com",
      first_name: "Mike",
      last_name: "Hernandez",
      password: "mike",
      token: ENV['GITHUB_API_KEY']
    )
    
    @github_service = GithubService.new
  end

  it 'can get a response for user repos' do
    expect(@github_service.user_repos(@user.token).first).to have_key :name
    expect(@github_service.user_repos(@user.token).first).to have_key :html_url
  end

  it 'can get a response for user github followers' do
    expect(@github_service.user_followers(@user.token).first).to have_key :login
    expect(@github_service.user_followers(@user.token).first).to have_key :html_url
  end

  it 'can get a response for github users followed by registered user' do
    expect(@github_service.user_following(@user.token).first).to have_key :login
    expect(@github_service.user_following(@user.token).first).to have_key :html_url
  end
end
