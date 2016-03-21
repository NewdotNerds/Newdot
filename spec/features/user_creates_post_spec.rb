require "rails_helper"

RSpec.describe "Creating post" do
  let(:user) { create(:user) }
  scenario "successfully" do
    sign_in user
    visit root_path
    click_on "Write a story"

    fill_in "Title", with: "My first post"
    fill_in "Body", with: "Some awesome content" 
    click_on "Publish"

    within(".posts") do
      expect(page).to have_content "My first post"
      expect(page).to have_content user.username
    end
  end

  scenario "unsuccessfully" do
    sign_in user
    visit root_path
    click_on "Write a story"

    fill_in "Title", with: "My second post"
    fill_in "Body", with: ""
    click_on "Publish"

    expect(page).to have_css ".error"
  end

  scenario "non-logged in user cannot create post" do
    visit root_path
    click_on "Write a story"

    expect(current_path).to eq(new_user_session_path)
  end
end

