require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'relationships' do
    it { should have_many(:user_videos).dependent(:destroy) }
    it { should have_many(:friended)}
    it { should have_many(:friended).through(:friends) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'class methods' do
    it 'knows if a github name is in the database' do
      user1 = create(:user)
      user3 = create(:user)
      user2 = User.create(email: "mike@mike.com",
                         first_name: "Mike",
                         last_name: "Hernandez",
                         password: "mike",
                         token: ENV['GITHUB_API_KEY'],
                         github_login: 'mikez321'
                        )

      expect(User.in_database?(user1.github_login)).to eq(false)
      expect(User.in_database?(user2.github_login)).to eq(true)
    end
  end
end
