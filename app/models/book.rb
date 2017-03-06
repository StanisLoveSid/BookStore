class Book < ApplicationRecord
  paginates_per 2
  belongs_to :user
  belongs_to :category
  belongs_to :author
  has_many :reviews, dependent: :destroy
  has_many :book_attachments, dependent: :destroy
  accepts_nested_attributes_for :book_attachments
  has_many :order_items, dependent: :destroy
  default_scope { where(active: true) }
end
