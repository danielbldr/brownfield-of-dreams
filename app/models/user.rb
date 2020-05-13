class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos
  has_many :friends
  has_many :friended, through: :friends

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :first_name, presence: true

  enum role: { default: 0, admin: 1 }
  has_secure_password

  def self.in_database?(username)
    User.where(github_login: username).exists? && !username.nil?
  end

  def not_yet_friends?(follower)
    friend = User.where(github_login: follower.login).first
    return false if friend.friended.include?(self)

    true
  end
end
