require 'rails_helper'

RSpec.describe Friend do
  describe 'relationships' do
    it {should belong_to :user}
    it {should belong_to :friended}
  end
end
