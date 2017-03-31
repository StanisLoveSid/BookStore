class AddDeliveryRefToOrder < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :delivery, foreign_key: true, default: 21
  end
end
