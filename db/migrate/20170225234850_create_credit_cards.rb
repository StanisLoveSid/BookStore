class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.string :cvv
      t.integer :year
      t.integer :month
      t.string :first_name
      t.string :last_name
      t.timestamps
    end
    add_reference :credit_cards, :user, index: true, foreign_key: true
    add_reference :credit_cards, :order, index: true, foreign_key: true
  end
end
