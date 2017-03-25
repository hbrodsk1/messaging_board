FactoryGirl.define do
	factory :user do
		sequence(:email)    { |n| "test_user#{n}@email.com" }
		sequence(:first_name) { |n| "test_user_first_name#{n}" }
		sequence(:last_name) { |n| "test_user_last_name#{n}" }
  		sequence(:about_me)    { |n| "test_user_about_me#{n}" }
		password "password"
	end

	factory :invalid_user, class: User do
		email ""
		first_name ""
		last_name ""
		password ""
	end
end