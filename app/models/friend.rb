class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :friended, class_name: 'User'

  after_create :create_inverse

  def create_inverse
    Friend.create(user_id: friended.id, friended_id: user.id)
  end

  # validates_uniqueness_of :user_id, scope: :friended_id
  validates :user_id, uniqueness: true
end
