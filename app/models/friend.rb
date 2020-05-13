class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :friended, class_name: 'User'

  after_create :create_inverse

  def create_inverse
    self.class.create(user_id: self.friended.id, friended_id: self.user.id)
  end

  validates_uniqueness_of :user_id, scope: :friended_id
end
