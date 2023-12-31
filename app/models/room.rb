class Room < ApplicationRecord
  has_many_attached :photos
  has_many :reservations
  has_many :users, through: :reservations

  validates :description, :capacity, :price, presence: true
end
