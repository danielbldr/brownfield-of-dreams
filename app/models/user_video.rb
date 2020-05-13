class UserVideo < ApplicationRecord
  belongs_to :video
  belongs_to :user

  def self.bookmarked_videos(user_id)
    Video.joins(:user_videos)
         .where('user_videos.user_id = ?', user_id)
         .order(:tutorial_id, :position)
  end
end
