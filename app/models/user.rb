class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos
  has_many :friends, dependent: :nullify
  has_many :friended, through: :friends

  validates :email, uniqueness: true, presence: true
  validates :password_digest, presence: true
  validates :first_name, presence: true

  enum role: { default: 0, admin: 1 }
  has_secure_password

  def self.in_database?(username)
    User.where(github_login: username).exists? && !username.nil?
  end

  def friends?(follower)
    friend = User.find_by(github_login: follower)
    return true if friend.friended.include?(self)

    false
  end

  def status
    return 'Active' if active == true

    'Pending Activation'
  end
end
