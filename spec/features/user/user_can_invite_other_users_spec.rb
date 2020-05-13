require 'rails_helper'

RSpec.describe 'as A user I can invite other users to join this app', type: :feature do
  describe 'when I visit my dashboard I see a link to invite users via github' do
    scenario "if they don't have an email they can't get an invite", :vcr do
      user = User.create(email: "mike@mike.com",
                         first_name: "Mike",
                         last_name: "Hernandez",
                         password: "mike",
                         token: ENV['GITHUB_API_KEY']
                        )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      click_link "Send an Invite"

      expect(current_path).to eq("/invite")

      fill_in "Github handle", with: "danielbldr"

      click_button "Send Invite"

      expect(current_path).to eq dashboard_path

      expect(page).to_not have_content("Successfully sent invite!")

      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end

    scenario "if the user has an email listed they get an invite", :vcr do
      user = User.create(email: "dan@dan.com",
                         first_name: "Daniel",
                         last_name: "Atkinson",
                         password: "daniel",
                         token: ENV['MY_GITHUB_KEY']
                        )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      click_link "Send an Invite"

      expect(current_path).to eq("/invite")

      fill_in "Github handle", with: "mikez321"

      click_button "Send Invite"

      expect(current_path).to eq dashboard_path

      expect(page).to have_content("Successfully sent invite!")

      expect(page).to_not have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end
end
