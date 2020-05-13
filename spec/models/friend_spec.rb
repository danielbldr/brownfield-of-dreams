require 'rails_helper'

RSpec.describe Friend do
  describe 'relationships' do
    it {should belong_to :user}
    it {should belong_to :friended}
  end

  describe 'instance_methods' do
    it 'automatically creates friend/friended entries' do
      user1 = User.create(email: "mike@mike.com",
                         first_name: "Mike",
                         last_name: "Hernandez",
                         password: "mike",
                         token: ENV['GITHUB_API_KEY'],
                         github_login: 'mikez321'
                        )
      user2 = User.create(email: "atkinson.daniel7@gmail.com",
                         first_name: "Daniel",
                         last_name: "Atkinson",
                         password: "mike",
                         token: ENV['MY_GITHUB_KEY'],
                         github_login: 'danielbldr'
                        )

      Friend.create(user_id: user1.id, friended_id: user2.id)

      expect(user1.friends?(user2.github_login)).to eq(true)
      expect(user2.friends?(user1.github_login)).to eq(true)
    end
  end
end
