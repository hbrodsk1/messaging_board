class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, :body, :author, :user_id, presence: true
end
