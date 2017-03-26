class OrderForm < Rectify::Form
  include ActiveModel::Validations
  attribute :id, Integer
  attribute :subtotal, BigDecimal
  attribute :user_id, Integer
  attribute :coupon, String
  attribute :order_items, Array[OrderItemForm]

end

