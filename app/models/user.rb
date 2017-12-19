class User < ApplicationRecord
	has_many :places
	has_many :reviews
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
