class CreateDelivery < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveries do |t|
      t.string :name
      t.decimal :price
    end
  end
end
