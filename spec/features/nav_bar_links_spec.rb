require "rails_helper"

RSpec.feature "mav-bar links spec", type: :feature do
	scenario 'A user is logged in' do
		@user = FactoryGirl.create(:user)

		login_as(@user)
		visit '/posts'

		expect(page).to have_link("sign-out-link")
	end

	scenario 'No user is logged in' do
		visit '/posts'

		expect(page).to have_link("sign-in-link")
		expect(page).to have_link("sign-up-link")
	end
end