class OrderItemForm < Rectify::Form
  attribute :book_id,  Integer
  attribute :quantity, Integer
  attribute :id, Integer
end