class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :text_of_review
      t.integer :book_id
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
    add_index :reviews, :book_id
  end
end
