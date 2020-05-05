require 'rails_helper'

describe 'An admin user can create new tutorials' do
  it 'clicks on the add tutorial button' do
    admin = create(:user, role: 1)
    tutorial = create(:tutorial)
    video1 = create(:video, tutorial_id: tutorial.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    click_link "New Tutorial"

    expect(current_path).to eq('/admin/tutorials/new')
  end
end
