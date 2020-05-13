require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :description}
    it {should validate_presence_of :thumbnail}
  end

  describe 'relationships' do
    it { should have_many :videos }
  end

  describe 'instance methods' do
    it 'can create its video' do
      tutorial = create(:tutorial)
      video1 = {snippet: {title: 'thing',
                          description: "desc",
                          thumbnails: {
                              standard: {
                                  url: 'https://i.ytimg.com/vi/Uamswxg21Zo/sddefault.jpg'
                              }
                          },
                          resourceId: {
                            videoId: 1
                            },
                          position: 1}}
      video2 = {snippet: {title: 'thing',
                          description: 'desc',
                          thumbnails: {
                              standard: {
                                  url: 'https://i.ytimg.com/vi/Uamswxg21Zo/sddefault.jpg'
                              }
                            },
                          resourceId: {
                            videoId: 2
                          },
                          position: 2}}
      videos = [video1, video2]

      expect(tutorial.videos.length). to eq(0)

      tutorial.create_videos(videos)

      expect(tutorial.videos.length). to eq(2)
    end
  end
end
