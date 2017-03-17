class CreditCardForm < Rectify::Form
  include ActiveModel::Validations

  attribute :first_name, String
  attribute :last_name,  String
  attribute :number,    String
  attribute :cvv,       Integer
  attribute :year,      Integer
  attribute :month,     Integer
  attribute :user_id,   Integer
  attribute :order_id,  Integer
  attribute :expiration_date, Integer

end