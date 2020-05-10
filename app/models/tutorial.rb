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
    videos.each do |vid|
      self.videos.create(title: vid[:snippet][:title],
                         description: vid[:snippet][:description],
                         video_id: vid[:id],
                         thumbnail: vid[:snippet][:thumbnails][:standard][:url],
                         position: vid[:snippet][:position])
    end
  end
end
