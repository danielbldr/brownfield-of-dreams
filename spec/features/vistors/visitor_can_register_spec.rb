require 'rails_helper'

describe 'visitor can create an account', :js do
  it ' visits the home page' do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on'Create Account'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content(email)
    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name)
    expect(page).to_not have_content('Sign In')
  end

  it 'visitors cant create an account if the username already exists' do

    user = User.create(email: "mike@mike.com",
                       first_name: "Mike",
                       last_name: "Hernandez",
                       password: "mike",
                      )

    visit new_user_path

    fill_in 'Email', with: 'mike@mike.com'
    fill_in 'First name', with: 'Mike'
    fill_in 'Last name', with: 'Hernandez'
    fill_in 'Password', with: 'mike'
    fill_in 'Password confirmation', with: 'mike'

    click_on'Create Account'
    
    expect(current_path).to eq(new_user_path)
    expect(page).to have_content('Username already exists')
  end
end
