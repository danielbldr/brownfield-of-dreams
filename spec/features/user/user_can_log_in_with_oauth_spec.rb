require 'rails_helper'

RSpec.describe 'as a user when I visit my dashboard' do
  it 'I can connect to Github through OAuth', :vcr do
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      :uid => '50503353',
      "credentials"=>{"token"=>ENV['MY_GITHUB_KEY'], "expires"=>false},
      })

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to_not have_css(".#{user.first_name}-repos")
    expect(page).to_not have_css(".#{user.first_name}-following")
    expect(page).to_not have_css(".#{user.first_name}-followers")

    click_link 'Connect to Github'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_css(".#{user.first_name}-repos")
    expect(page).to have_css(".#{user.first_name}-following")
    expect(page).to have_css(".#{user.first_name}-followers")
  end
end
