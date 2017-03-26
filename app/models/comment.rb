class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :body, :author, :user_id, :post_id, presence: true
end
