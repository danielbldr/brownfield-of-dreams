class GithubResults
  def get_repos(token)
    github_service = GithubService.new
    json = github_service.user_repos(token)
    json.map { |repo| Repo.new(repo) }
  end
  
  def get_followers(token)
    github_service = GithubService.new
    json = github_service.user_followers(token)
    json.map { |repo| Follower.new(repo) }
  end
  
  def get_following(token)
    github_service = GithubService.new
    json = github_service.user_following(token)
    json.map { |following_user_info| Following.new(following_user_info)}
  end
end
