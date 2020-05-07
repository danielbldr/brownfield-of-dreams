class Repo
  attr_reader :name, :html_url

  def initialize(repo_info)
    @name = repo_info[:name]
    @html_url = repo_info[:html_url]
  end
end
