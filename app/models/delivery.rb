class Delivery < ApplicationRecord
  has_many :orders

  validates :name,
    presence: true,
    uniqueness: true

  validates :price,
    presence: true
end
