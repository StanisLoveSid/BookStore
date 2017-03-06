class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

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
