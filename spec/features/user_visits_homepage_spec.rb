require "rails_helper"

RSpec.feature "User visits homepage" do
	scenario "succesfully and sees a logo" do
		visit root_path
		expect(page).to have_content "Myapp"
	end
end