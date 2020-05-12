class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :first_name, presence: true

  enum role: { default: 0, admin: 1 }
  has_secure_password

  def self.in_database?(username)
    return false if User.where(github_login: username) == []
      true
  end
end
