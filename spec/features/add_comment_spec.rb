require "rails_helper"

RSpec.feature "Add a new post", type: :feature do
	scenario 'A user creates a valid comment' do
		@user = FactoryGirl.create(:user)
		@post = FactoryGirl.create(:post, user: @user)

		login_as(@user)
		visit "/posts/#{@post.id}"


		first('#comment-post-id', visible: false).set("#{@post.id}")
		first('#comment-user-id', visible: false).set("#{@user.id}")
		first('#comment-author', visible: false).set("#{@user.first_name}")
		fill_in('comment-body', with: "Hello, this is a valid comment")
		click_button('comment-submit-button')

		expect(page).to have_current_path(post_path(id: @post.id))
	end

	scenario 'A user creates an invalid comment' do
		@user = FactoryGirl.create(:user)
		@post = FactoryGirl.create(:post, user: @user)

		login_as(@user)
		visit "/posts/#{@post.id}"


		first('#comment-post-id', visible: false).set("#{@post.id}")
		first('#comment-user-id', visible: false).set("#{@user.id}")
		first('#comment-author', visible: false).set("#{@user.first_name}")
		fill_in('comment-body', with: "")
		click_button('comment-submit-button')

		expect(page).to have_current_path(comments_path)
	end
end