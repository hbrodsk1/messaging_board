require "rails_helper"

RSpec.feature "log in/log out", type: :feature do
	scenario 'user logs in with valid credentials' do
		@user = FactoryGirl.create(:user)

		visit 'users/sign_in'
		fill_in('Email', with: @user.email)
		fill_in('Password', with: @user.password)

		click_button('login-button')

		expect(page).to have_current_path(root_path)
	end

	scenario 'user logs in with invalid credentials' do
		@invalid_user = FactoryGirl.build(:invalid_user)

		visit 'users/sign_in'
		fill_in('Email', with: @invalid_user.email)
		fill_in('Password', with: @invalid_user.password)

		click_button('login-button')

		expect(page).to have_current_path(new_user_session_path)
	end
end