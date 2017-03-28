require "rails_helper"

RSpec.feature "Add a new comment", type: :feature do
	scenario 'A user creates a valid comment' do
		@user = FactoryGirl.create(:user)
		@post = FactoryGirl.create(:post)
		@comment = FactoryGirl.attributes_for(:comment, user_id: @user.id, post_id: 6)

		login_as(@user)
		visit "/posts/#{@post.id}"

		fill_in('comment-body', with: "Valid Comment Body")
		click_button('comment-submit-button')

		expect(page).to have_current_path(post_path("#{@post.id}"))
	end

	scenario 'A user creates an invalid comment' do
		@user = FactoryGirl.create(:user)
		@post = FactoryGirl.create(:post, user: @user)

		login_as(@user)
		visit "/posts/#{@post.id}"

		fill_in('comment-body', with: "")
		click_button('comment-submit-button')

		expect(page).to have_current_path(comments_path)
	end
end