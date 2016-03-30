require "rails_helper"

RSpec.feature "Viewing bookmarked posts" do
  let(:user) { create(:user) }
  let!(:post_1) { create(:post, title: "Interesting post") }
  let!(:post_2) { create(:post, title: "Not so interesting post") }

  background do
    user.add_bookmark_to(post_1)
  end

  scenario "Signed in user can view his/hew bookmarked post in bookmark page" do
    sign_in user
    visit dashboard_path
    click_on "Bookmarks"

    expect(page).to have_link "Interesting post"
    expect(page).not_to have_link "Not so interesting post"
  end

  scenario "non-logged in user cannot go to bookmarked post page" do
    visit root_path
    click_on "Bookmarks"
    expect(current_path).to eq(new_user_session_path)
  end
end