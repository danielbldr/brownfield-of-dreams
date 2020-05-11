require 'rails_helper'

RSpec.describe 'as a user when I visit my dashboard', type: :feature do
  describe 'I can see all the users I follow on Github' do
    it 'and their names are links to their Github profile', :vcr do
      user1 = User.create(email: "mike@mike.com",
                         first_name: "Mike",
                         last_name: "Hernandez",
                         password: "mike",
                         token: ENV['GITHUB_API_KEY']
                        )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit dashboard_path

      within ".#{user1.first_name}-following" do
        expect(page).to have_link("leepanter")
        expect(page).to have_link("DavidTTran")
        expect(page).to have_link("tylertomlinson")
        page.assert_selector(:css, 'a[href="https://github.com/leepanter"]')
      end
    end
  end
end
