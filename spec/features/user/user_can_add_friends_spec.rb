require 'rails_helper'

RSpec.describe 'a user can add friends from their github followers' do
  scenario 'a logged in use can see links to add friends from followers', :vcr do
    user1 = User.create(email: "mike@mike.com",
                       first_name: "Mike",
                       last_name: "Hernandez",
                       password: "mike",
                       token: ENV['GITHUB_API_KEY'],
                       github_login: 'mikez321'
                      )
    user2 = User.create(email: "atkinson.daniel7@gmail.com",
                       first_name: "Daniel",
                       last_name: "Atkinson",
                       password: "mike",
                       token: ENV['MY_GITHUB_KEY'],
                       github_login: 'danielbldr'
                      )
    user3 = User.create(email: "bob@example.com",
                       first_name: "Bob",
                       last_name: "Example",
                       password: "mike",
                      )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit dashboard_path

    within ".Mike-followers" do
      expect(page).to have_content("danielbldr")
      expect(page).to have_content("leepanter")
    end

    within ".follower-leepanter" do
      expect(page).to_not have_link "Add Friend"
    end

    within ".Mike-following" do
      expect(page).to have_content("danielbldr")
      expect(page).to have_content("leepanter")
    end

    within ".following-leepanter" do
      expect(page).to_not have_link "Add Friend"
    end

    within ".follower-danielbldr" do
      click_link "Add Friend"
    end

  end
end
