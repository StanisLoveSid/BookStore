class AddItemIdToBook < ActiveRecord::Migration[5.0]
  def change
  	add_column :books, :order_item_id, :integer
  end
end
