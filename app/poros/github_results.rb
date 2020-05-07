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
end
