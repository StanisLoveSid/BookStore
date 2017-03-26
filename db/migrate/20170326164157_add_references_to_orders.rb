class AddReferencesToOrders < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :credit_card, index: true, foreign_key: true
  end
end
