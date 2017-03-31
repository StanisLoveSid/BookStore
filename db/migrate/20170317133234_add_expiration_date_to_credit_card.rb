class AddExpirationDateToCreditCard < ActiveRecord::Migration[5.0]
  def change
    add_column :credit_cards, :expiration_date, :integer
  end
end
