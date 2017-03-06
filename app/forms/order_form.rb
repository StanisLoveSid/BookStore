class OrderForm < Rectify::Form
  include ActiveModel::Validations

  attribute :subtotal, BigDecimal
  attribute :user_id, Integer

end