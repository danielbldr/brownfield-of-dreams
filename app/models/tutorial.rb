class Tutorial < ApplicationRecord
  has_many :videos,
           -> { order(position: :ASC) },
           inverse_of: :tutorial,
           dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  validates :title, presence: true
  validates :description, presence: true
  validates :thumbnail, presence: true

  def create_videos(videos)
    videos.each do |video|
      self.videos.create(title: video[:snippet][:title],
                         description: video[:snippet][:description],
                         video_id: video[:id],
                         thumbnail: video[:snippet][:thumbnails][:standard][:url],
                         position: video[:snippet][:position])
    end
  end
end
