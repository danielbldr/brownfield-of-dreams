require 'rails_helper'

describe 'visitor sees a video show' do
  it 'vistor clicks on a tutorial title from the home page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit '/'

    click_on tutorial.title

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content(video.title)
    expect(page).to have_content(tutorial.title)
  end

  it 'visitor cannot visit a tutorial that is classroom content only' do
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial, classroom: true)
    video1 = create(:video, tutorial_id: tutorial1.id)
    video2 = create(:video, tutorial_id: tutorial2.id)

    visit '/'

    expect(page).to have_link(tutorial1.title)
    expect(page).to_not have_link(tutorial2.title)

    visit "/tutorials/#{tutorial2.id}"
    expect(page).to_not have_content(video2.title)
    expect(page).to_not have_content(tutorial2.title)
    expect(page).to have_content('Please Sign In or Register to continue')
  end
end
