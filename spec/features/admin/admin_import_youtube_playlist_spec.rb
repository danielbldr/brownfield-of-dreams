require 'rails_helper'

describe 'As an admin I can click new tutorial on the dashboard' do
  describe 'I can then click Import Youtube Playlist', :vcr do
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

      expect(current_path).to eq(admin_dashboard_path)

      within('.flash-message') do
        expect(page).to have_content('Successfully created tutorial. View it here')
        click_link 'View it here'
      end

      expect(page).to have_link('An Interview with Mark Robberds on Ashtanga Yoga')
      expect(page).to have_link('Ashtanga Yoga - Forearm Balance, Pinchamayurasana with Mark Robberds')
      expect(page).to have_link('Karandavasana | Ashtanga Yoga with Mark Robberds')
      expect(page).to have_link('Yoga Arm Balance - Mayurasana with Mark Robberds')
      expect(page).to have_link('Nakrasana | Crocodile Posture | Mark Robberds')
    end

    it 'I can import more than 50 videos at a time' do
      admin = create(:user, role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/dashboard'
      click_link 'New Tutorial'

      fill_in "Title", with: 'Yoga for Beginners'
      fill_in "Description", with: "Yoga with Kino"
      fill_in "Thumbnail", with: "https://img.youtube.com/vi/frVPA_mLXh4/maxresdefault.jpg"

      click_link 'Import YouTube Playlist'

      fill_in :tutorial_playlist_id, with: "PL508C30656B253DBF"

      click_button 'Save'

      within('.flash-message') do
        expect(page).to have_content('Successfully created tutorial. View it here')
        click_link 'View it here'
      end

      expect(page).to have_css('.video', count: 75)

      expect('40 Minute Beginner Yoga for Strength and Flexibility').to appear_before('Beginner Ashtanga, One Hour Modified Primary Series')
      expect('Beginner Ashtanga, One Hour Modified Primary Series').to appear_before('Sunset Yoga for Relaxation — 15 Minute Practice')
      expect('Sunset Yoga for Relaxation — 15 Minute Practice').to appear_before('Easy Beginner Yoga for Everyone — 20 Minute Practice')
    end
  end
end
