require 'rails_helper'

describe 'as a user I can visit my dahsboard' do
  scenario 'I can see my github repos' do
    user = User.create(email: "mike@mike.com",
                       first_name: "Mike",
                       last_name: "Hernandez",
                       password: "mike",
                       github_name: "mikez321",
                       token: ENV['GITHUB_API_KEY']
                      )

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(page).to have_css(".github-repos")

    within ".github-repos" do
      expect(page).to have_content("activerecord-obstacle-course")
    end
  end
end
