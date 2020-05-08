require 'rails_helper'

describe 'as a user I can visit my dahsboard' do
  scenario 'I can see my followers on github' do
    user1 = User.create(email: "mike@mike.com",
                       first_name: "Mike",
                       last_name: "Hernandez",
                       password: "mike",
                       token: ENV['GITHUB_API_KEY']
                      )
    user2 = User.create(email: "atkinson.daniel7@gmail.com",
                       first_name: "Daniel",
                       last_name: "Atkinson",
                       password: "mike",
                       token: ENV['MY_GITHUB_KEY']
                      )
    user3 = User.create(email: "bob@example.com",
                       first_name: "Bob",
                       last_name: "Example",
                       password: "mike",
                      )
    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user1.email
    fill_in 'session[password]', with: user1.password

    click_on 'Log In'

    within ".#{user1.first_name}-followers" do
      expect(page).to have_link('leepanter')
      expect(page).to have_link('alex-latham')
      expect(page).to have_link('DavidTTran')
      expect(page).to have_link('tylertomlinson')
      page.assert_selector(:css, 'a[href="https://github.com/tylertomlinson"]')
    end

    click_button "Log Out"

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user2.email
    fill_in 'session[password]', with: user2.password

    click_on 'Log In'

    expect(page).to_not have_css(".#{user1.first_name}-followers")

    within ".#{user2.first_name}-followers" do
      expect(page).to have_link('SMJ289')
      expect(page).to have_link('alex-latham')
      expect(page).to have_link('DavidTTran')
      expect(page).to have_link('javier-aguilar')
      page.assert_selector(:css, 'a[href="https://github.com/DavidTTran"]')
    end

    click_button "Log Out"

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user3.email
    fill_in 'session[password]', with: user3.password

    click_on 'Log In'

    expect(page).to_not have_content("Your Github Followers")
  end
end
