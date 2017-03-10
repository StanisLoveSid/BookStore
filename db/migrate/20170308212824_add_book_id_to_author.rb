class AddBookIdToAuthor < ActiveRecord::Migration[5.0]
  def change
    add_column :authors, :book_id, :integer
  end
end
