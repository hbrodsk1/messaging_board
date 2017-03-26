FactoryGirl.define do
  factory :comment do
    body "MyText"
    author "MyString"
    user
    post
  end

  factory :invalid_comment, class: Comment do
  	body nil
    author "MyString"
    user
    post
  end
end
