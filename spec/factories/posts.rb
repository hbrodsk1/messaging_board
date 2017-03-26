FactoryGirl.define do
  factory :post do
    title "MyString"
    body "MyText"
    author "name"
    user
  end

  factory :invalid_post, class: Post do
    title nil
    body "MyText"
    author "name"
    user
  end
end
