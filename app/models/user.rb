class User < ActiveRecord::Base
	has_many :posts
	validates :first_name, :last_name, :email, :encrypted_password, presence: true
	validates :email, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
