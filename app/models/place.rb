class Place < ApplicationRecord
	belongs_to :user
	belongs_to :category
	validates_presence_of :address, :latitude, :longitude, :category
	geocoded_by :address, :lookup => :yandex
	after_validation :geocode
end
