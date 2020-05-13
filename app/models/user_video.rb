class UserVideo < ApplicationRecord
  belongs_to :video
  belongs_to :user

  def self.bookmarked_videos(user_id)
    require "pry"; binding.pry
    Video.joins(%I[tutorial user_videos]).order(:tutorial_id, :position)
  end
end
