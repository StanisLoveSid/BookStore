class AddBooksToCategory < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :book_id
    end
    add_index :categories, :book_id
  end
end
