require 'rails_helper'

describe 'Follower' do
  it 'can return info about itself' do
    follower_info = {login: "Daniel", html_url: "www.example.com"}
    follower = Follower.new(follower_info)

    expect(follower.login).to eq(follower_info[:login])
    expect(follower.html_url).to eq(follower_info[:html_url])
  end
end
