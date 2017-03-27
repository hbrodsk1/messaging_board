require "rails_helper"

RSpec.feature "Add a new post", type: :feature do
	scenario 'A user creates a valid post' do
		@post = FactoryGirl.attributes_for(:post)
		@post[:user] = FactoryGirl.create(:user)

		login_as(@post[:user])
		visit "posts/new"

		fill_in('Title', with: @post[:title])
		fill_in('Post', with: @post[:body])

		click_button('Submit')

		expect(page).to have_current_path(root_path)
	end

	scenario 'A user creates an invalid post' do
		@post = FactoryGirl.attributes_for(:invalid_post)
		@post[:user] = FactoryGirl.create(:user)

		login_as(@post[:user])
		visit "posts/new"

		fill_in('Title', with: @post[:title])
		fill_in('Post', with: @post[:body])

		click_button('Submit')

		expect(page).to have_button('Submit')
	end
end