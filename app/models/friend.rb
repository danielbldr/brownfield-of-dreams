class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :friended, class_name: 'User'

  validates :user_id, uniqueness: true

  after_create :create_inverse

  def create_inverse
    Friend.create(user_id: friended.id, friended_id: user.id)
  end
end
