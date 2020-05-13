class UserVideo < ApplicationRecord
  belongs_to :video
  belongs_to :user

  def self.bookmarked_vidoes
    Video.joins(%I[tutorial user_videos]).order(:tutorial_id, :position)
  end
end
