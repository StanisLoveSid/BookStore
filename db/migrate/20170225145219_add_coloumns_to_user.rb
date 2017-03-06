class AddColoumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :zipcode, :integer
    add_column :users, :phone, :string
    add_column :users, :country, :string
  end
end
