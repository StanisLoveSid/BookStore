class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.references :book, foreign_key: true
      t.references :order, foreign_key: true
      t.decimal :unit_price
      t.integer :quantity
      t.decimal :total_price

      t.timestamps
    end
  end
end
