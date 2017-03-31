class CreateBookAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :book_attachments do |t|
      t.integer :book_id
      t.string :photo

      t.timestamps null: false
    end
  end
end
