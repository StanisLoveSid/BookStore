class CreateBooksAuthorsAssociation < ActiveRecord::Migration[5.0]
  def self.up
    create_table :authors_books, :id => false do |t|
      t.integer :book_id
      t.integer :author_id
    end
  end
 
  def self.down
    drop_table :authors_books
  end
end
