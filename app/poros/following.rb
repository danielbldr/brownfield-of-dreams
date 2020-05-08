class Following
  attr_reader :login, :html_url
  def initialize(following_info)
    @login = following_info[:login]
    @html_url = following_info[:html_url]
  end
end
