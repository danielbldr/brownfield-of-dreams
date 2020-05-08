require 'rails_helper'

RSpec.describe 'following' do
  describe 'instance methods' do
    it 'has attributes' do
      info = {login: 'abraham_lincoln',
              html_url: 'https://www.whitehouse.gov/about-the-white-house/presidents/abraham-lincoln/'}
      following = Following.new(info)

      expect(following.login).to eq(info[:login])
      expect(following.html_url).to eq(info[:html_url])
    end
  end
end
