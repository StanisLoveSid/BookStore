class Category < ApplicationRecord
  has_many :books
  belongs_to :user
  validates :name,
    presence: true,
    uniqueness: { case_sensitive: false }
end
