require "rails_helper"

RSpec.feature "About me", type: :feature do
	scenario 'A user with an about me' do
		@user = FactoryGirl.create(:user, about_me: "Hello")

		login_as(@user)
		visit "/users/#{@user.id}"

		expect(page).to have_css("p", :text => "Hello")
	end

	scenario 'A user without an about me' do
		@user = FactoryGirl.create(:user, about_me: "")

		login_as(@user)
		visit "/users/#{@user.id}"

		expect(page).to have_css("p", :text => "This user does not have an 'About me'")
	end
end