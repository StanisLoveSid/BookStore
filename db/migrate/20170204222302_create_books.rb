class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author_name 
      t.integer :pick_times
      t.text :description
      t.integer :price
      t.boolean :bestseller, default: false
      t.timestamps null: false
    end
  end
end
