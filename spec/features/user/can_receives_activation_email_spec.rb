require 'rails_helper'

describe 'User' do
  it 'user can regrister and receive activation email' do
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
    expect(User.last.active).to eq(false)
    expect(page).to have_content('Status: Pending Activation')
    expect(page).to have_content("Logged in as #{first_name}")
    expect(page).to have_content('This account has not yet been activated. Please check your email.')

    visit "/users/#{User.last.id}"

    expect(User.last.active).to eq(true)
    expect(page).to have_content('Status: Active')
    expect(page).to have_content('Thank you! Your account is now activated.')
  end
end
