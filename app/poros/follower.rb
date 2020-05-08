class Follower
  attr_reader :login, :html_url

  def initialize(follower_info)
    @login = follower_info[:login]
    @html_url = follower_info[:html_url]
  end
end
