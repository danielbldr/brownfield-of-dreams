require 'rails_helper'

RSpec.describe 'as an admin user I can see the admin dashboard', type: :feature do
  scenario 'I am logged in as an admin user' do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    expect(page).to have_content "Admin Dashboard"
  end

  scenario 'I am a visitor' do
    visit admin_dashboard_path

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario 'I am a default user' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit admin_dashboard_path

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
