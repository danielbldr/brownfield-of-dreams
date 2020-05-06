require 'rails_helper'

describe 'An admin user can create new tutorials' do
  before(:each) do
    @admin = create(:user, role: 1)
    @tutorial = create(:tutorial)
    @video1 = create(:video, tutorial_id: @tutorial.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end
  it 'clicks on the add tutorial button' do
    visit "/admin/dashboard"

    click_link "New Tutorial"

    expect(current_path).to eq('/admin/tutorials/new')

    fill_in "Title", with: "How to make toast"
    fill_in "Description", with: "It's not just for dinner!"
    fill_in "Thumbnail", with: "https://img.youtube.com/vi/pX0eJBvBNzs/maxresdefault.jpg"

    click_button "Save"

    expect(current_path).to eq("/tutorials/#{Tutorial.all.last.id}")

    expect(page).to have_content("Successfully created tutorial.")

    within(".tutorials") do
      expect(page).to have_content("How to make toast")
    end
  end

  it 'must be a properly filled out form' do
    visit "/admin/tutorials/new"

    fill_in "Description", with: "It's not just for dinner!"
    fill_in "Thumbnail", with: "https://img.youtube.com/vi/pX0eJBvBNzs/maxresdefault.jpg"

    click_button "Save"

    expect(current_path).to eq("/admin/tutorials/new")

    expect(page).to have_content("Title can't be blank")

    fill_in "Title", with: "How to make toast"
    fill_in "Thumbnail", with: "https://img.youtube.com/vi/pX0eJBvBNzs/maxresdefault.jpg"

    click_button "Save"

    expect(current_path).to eq("/admin/tutorials/new")

    expect(page).to have_content("Description can't be blank")

    fill_in "Title", with: "How to make toast"
    fill_in "Description", with: "It's not just for dinner!"

    click_button "Save"

    expect(current_path).to eq("/admin/tutorials/new")

    expect(page).to have_content("Thumbnail can't be blank")
  end
end
