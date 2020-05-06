require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    it 'can see a list of tutorials not marked as classroom content only' do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)
      tutorial3 = create(:tutorial, classroom: true)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)
      video5 = create(:video, tutorial_id: tutorial3.id)
      video6 = create(:video, tutorial_id: tutorial3.id)

      visit root_path

      expect(page).to have_css('.tutorial', count: 2)

      within("#tutorial-#{tutorial1.id}") do
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)
      end

      within("#tutorial-#{tutorial2.id}") do
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial2.title)
        expect(page).to have_content(tutorial2.description)
      end
    end
  end
end
