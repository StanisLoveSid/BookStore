class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :rate,
    presence: true,
  numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5
  }

  STATES = [:unapproved, :approved]

  include AASM
  aasm do
    state :unapproved, :initial => true
    state :approved

    event :confirm do
      transitions :from => :unapproved, :to => :approved
    end
  end
end
