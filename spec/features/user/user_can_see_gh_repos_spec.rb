require 'rails_helper'

describe 'as a user I can visit my dahsboard' do
  scenario 'I can see my github repos' do
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

    within ".#{user1.first_name}-repos" do
      expect(page).to have_link("monster_shop_2001")
      expect(page).to have_link("futbol")
      expect(page).to have_link("brownfield-of-dreams")
      expect(page).to have_link("activerecord-obstacle-course")
      expect(page).to have_link("adopt_dont_shop_2001")
      page.assert_selector(:css, 'a[href="https://github.com/mikez321/adopt_dont_shop_2001"]')
    end

    click_button "Log Out"

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user2.email
    fill_in 'session[password]', with: user2.password

    click_on 'Log In'

    expect(page).to_not have_css(".#{user1.first_name}-repos")

    within ".#{user2.first_name}-repos" do
      expect(page).to have_link("activerecord-obstacle-course")
      expect(page).to have_link("adopt_dont_shop_2001")
      expect(page).to have_link("adopt_dont_shop_paired")
      expect(page).to have_link("b2-mid-mod")
      expect(page).to have_link("backend_module_0_capstone")
      page.assert_selector(:css, 'a[href="https://github.com/danielbldr/backend_module_0_capstone"]')
    end

    click_button "Log Out"

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user3.email
    fill_in 'session[password]', with: user3.password

    click_on 'Log In'

    expect(page).to_not have_content("Your Github Repos")
  end
end
