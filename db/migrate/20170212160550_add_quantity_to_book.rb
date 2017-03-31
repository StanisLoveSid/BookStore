class AddQuantityToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :quantity, :integer
    add_column :books, :active, :boolean
  end
end
