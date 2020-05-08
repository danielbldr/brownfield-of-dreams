require 'rails_helper'

describe 'As an admin I can click new tutorial on the dashboard' do
  describe 'I can then click Import Youtube Playlist' do
    it 'I see a form and can enter a valid Youtube Playlist id to create tutorial' do
      admin = create(:user, role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/dashboard'
      click_link 'New Tutorial'

      fill_in "Title", with: "Ashtanga with Mark Robberds"
      fill_in "Description", with: "Learn about traditional ashtanga yoga"
      fill_in "Thumbnail", with: "https://img.youtube.com/vi/frVPA_mLXh4/maxresdefault.jpg"

      click_link 'Import YouTube Playlist'

      fill_in :tutorial_playlist_id, with: "PLpfKu0U8zxt5rvqkZz8C6NDtjuXyl4HwW"

      click_button 'Save'

      expect(current_path).to eq('/admin/dashboard')
    end
  end
end
