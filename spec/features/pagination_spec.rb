require "rails_helper"

RSpec.feature "Pagination of posts", type: :feature do
	scenario 'There are more than three posts' do
		8.times { FactoryGirl.create(:post) }

		visit "/posts"

		expect(page).to have_selector('div.pagination')
	end

	scenario 'There are less than three posts' do
		2.times { FactoryGirl.create(:post) }

		visit "/posts"

		expect(page).not_to have_selector('div.pagination')
	end
end