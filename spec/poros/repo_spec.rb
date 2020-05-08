require 'rails_helper'

describe 'Repo' do
  it 'can return info about itself' do
    repo_info = {name: "Daniel", html_url: "www.example.com"}
    repo = Repo.new(repo_info)

    expect(repo.name).to eq(repo_info[:name])
    expect(repo.html_url).to eq(repo_info[:html_url])
  end
end
