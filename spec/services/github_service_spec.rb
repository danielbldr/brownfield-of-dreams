require 'rails_helper'

describe 'GithubService', type: :service do
  it 'can get user repos' do
    user = User.create(email: "mike@mike.com",
                       first_name: "Mike",
                       last_name: "Hernandez",
                       password: "mike",
                       token: ENV['GITHUB_API_KEY']
                      )

    github_service = GithubService.new

    expect(github_service.user_repos(user.token).first).to have_key :name
    expect(github_service.user_repos(user.token).first).to have_key :html_url
  end

  it 'can get users followed by the registered user' do
    user = User.create(email: "mike@mike.com",
                       first_name: "Mike",
                       last_name: "Hernandez",
                       password: "mike",
                       token: ENV['GITHUB_API_KEY']
                      )

    github_service = GithubService.new

    expect(github_service.user_following(user.token).first).to have_key :login
    expect(github_service.user_following(user.token).first).to have_key :html_url
  end
end
