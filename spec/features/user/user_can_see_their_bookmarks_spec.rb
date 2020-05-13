require 'rails_helper'

RSpec.describe 'as a user I can see my bookmarks' do
  scenario 'when I visit the dashboard I should see a list of my bookmarks', :vcr do
    tutorial1 = create(:tutorial)
    video1 = create(:video, tutorial_id: tutorial1.id, position: 0)
    video2 = create(:video, tutorial_id: tutorial1.id, position: 1)
    tutorial2 = create(:tutorial)
    video3 = create(:video, tutorial_id: tutorial2.id, position: 3)
    video4 = create(:video, tutorial_id: tutorial2.id, position: 1)

    user = User.create(email: "mike@mike.com",
                       first_name: "Mike",
                       last_name: "Hernandez",
                       password: "mike",
                       token: ENV['GITHUB_API_KEY']
                      )
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)


    visit tutorial_path(tutorial2.id)

    click_link video3.title

    click_button "Bookmark"

    click_link video4.title

    click_button "Bookmark"

    visit tutorial_path(tutorial1.id)

    click_link video2.title

    click_button "Bookmark"

    visit tutorial_path(tutorial1.id)

    click_link video1.title

    click_button "Bookmark"

    visit dashboard_path

    within ".bookmarks" do
      expect(page).to have_link(video1.title)
      expect(page).to have_link(video2.title)
      expect(page).to have_link(video3.title)
      expect(page).to have_link(video4.title)
    end

    within ".bookmarks" do
      expect(video1.title).to appear_before(video2.title)
      expect(video4.title).to appear_before(video3.title)
      expect(video2.title).to appear_before(video4.title)
      click_link video1.title
    end

    expect(page).to have_current_path "/tutorials/#{tutorial1.id}?video_id=#{video1.id}"
  end
end
