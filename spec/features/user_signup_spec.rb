require "rails_helper"

feature "User signs up" do
  scenario "successfully" do
    visit new_user_session_path
    fill_in "Username", with: "Example-User"
    fill_in "Email", with: "example@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Create Account"
    
    expect(page).to have_content "Sign out"
    expect(page).not_to have_content "Sign up"
  end
end
