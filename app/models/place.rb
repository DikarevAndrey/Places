class Place < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :reviews
	validates_presence_of :address, :coords
	validates_uniqueness_of :coords
end
