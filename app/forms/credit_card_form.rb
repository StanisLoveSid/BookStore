class CreditCardForm < Rectify::Form
  include ActiveModel::Validations

  attribute :first_name, String
  attribute :number,    String
  attribute :cvv,       Integer
  attribute :user_id,   Integer
  attribute :order_id,  Integer
  attribute :expiration_date, Integer

  validates :number,
    presence: true,
    numericality: { only_integer: true },
    length: { is: 16 }

  validates :cvv,
    presence: true,
    numericality: { only_integer: true },
    length: { is: 3 }

  validates :first_name,
    presence: true

  validates :expiration_date,
    presence: true

end
