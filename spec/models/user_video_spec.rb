require 'rails_helper'

RSpec.describe UserVideo, type: :model do
  it { should belong_to :user }
  it { should belong_to :video }
end

describe 'class methods' do
  it 'can return all bookmarked_videos ordered by tutorial and position' do
    user1 = create(:user)

    tutorial1 = create(:tutorial)
      video1 = create(:video, tutorial_id: tutorial1.id, position: 1)
      video2 = create(:video, tutorial_id: tutorial1.id, position: 4)
      video3 = create(:video, tutorial_id: tutorial1.id, position: 3)
      video4 = create(:video, tutorial_id: tutorial1.id, position: 2)
      video5 = create(:video, tutorial_id: tutorial1.id, position: 0)

    tutorial2 = create(:tutorial)
      video6 = create(:video, tutorial_id: tutorial2.id, position: 3)
      video7 = create(:video, tutorial_id: tutorial2.id, position: 1)

    UserVideo.create(user_id: user1.id, video_id: video1.id)
    UserVideo.create(user_id: user1.id, video_id: video2.id)
    UserVideo.create(user_id: user1.id, video_id: video3.id)
    UserVideo.create(user_id: user1.id, video_id: video4.id)
    UserVideo.create(user_id: user1.id, video_id: video6.id)
    UserVideo.create(user_id: user1.id, video_id: video7.id)

    expect(UserVideo.bookmarked_videos).to_not include(video5)
    expect(UserVideo.bookmarked_videos[0]).to eq(video1)
    expect(UserVideo.bookmarked_videos[1]).to eq(video4)
    expect(UserVideo.bookmarked_videos[2]).to eq(video3)

    expect(UserVideo.bookmarked_videos[4]).to eq(video7)
    expect(UserVideo.bookmarked_videos[5]).to eq(video6)

    expect(UserVideo.bookmarked_videos[4].tutorial).to eq(tutorial2)
    expect(UserVideo.bookmarked_videos[5].tutorial).to eq(tutorial2)
  end
end
