require "rails_helper"

RSpec.feature "Bookmarking a post" do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  scenario "signed_in user bookmarks a post successfully" do
  	sign_in user
  	visit post_path(post)
  	click_on "Bookmark"
  	expect(current_path).to eq(post_path(post))
  	expect(page).to have_button "Unbookmark"

  	click_on "Unbookmark"
  	expect(current_path).to eq(post_path(post))
  	expect(page).to have_button "Bookmark"
  end
end