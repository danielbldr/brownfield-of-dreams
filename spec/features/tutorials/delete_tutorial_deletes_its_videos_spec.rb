require 'rails_helper'

describe 'when a tutoral is deleted' do
  scenario 'all of its videos are also deleted from the db' do
    admin = create(:user, role: 1)
    tutorial1 = create(:tutorial)
    video1 = create(:video, tutorial_id: tutorial1.id)
    video2 = create(:video, tutorial_id: tutorial1.id)
    tutorial2 = create(:tutorial)
    video3 = create(:video, tutorial_id: tutorial2.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(Tutorial.all.count).to eq(2)
    expect(Video.all.count).to eq(3)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    expect(Tutorial.all.count).to eq(1)
    expect(Video.all.count).to eq(1)
    expect(Video.all.first.tutorial_id).to eq(tutorial2.id)
  end
end
