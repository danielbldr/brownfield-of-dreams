require 'rails_helper'

describe 'Github Results' do
  describe 'intstance methods' do
    it 'can return array of Repo objects' do
      results = GithubResults.new
      expect(results.get_repos(ENV['GITHUB_API_KEY'])).to be_an Array
      expect(results.get_repos(ENV['GITHUB_API_KEY']).first).to be_a Repo
      expect(results.get_repos(ENV['GITHUB_API_KEY']).last).to be_a Repo
    end
    
    it 'can return array of Follower objects' do
      results = GithubResults.new
      expect(results.get_followers(ENV['GITHUB_API_KEY'])).to be_an Array
      expect(results.get_followers(ENV['GITHUB_API_KEY']).first).to be_a Follower
      expect(results.get_followers(ENV['GITHUB_API_KEY']).last).to be_a Follower
    end

    it 'can return array of following objects' do
      results = GithubResults.new
      expect(results.get_following(ENV['GITHUB_API_KEY'])).to be_an Array
      expect(results.get_following(ENV['GITHUB_API_KEY']).first).to be_a Following
      expect(results.get_following(ENV['GITHUB_API_KEY']).last).to be_a Following
    end
  end
end
