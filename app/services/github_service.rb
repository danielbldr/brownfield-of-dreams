class GithubService
  def user_repos(user_token)
    response = conn(user_token).get('user/repos')
    JSON.parse(response.body, symbolize_names: true)
  end

  def user_followers(user_token)
    response = conn(user_token).get('user/followers')
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn(user_token)
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{user_token}"
    end
  end
end
