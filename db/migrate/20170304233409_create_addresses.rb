class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :zipcode
      t.string :city
      t.string :phone
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
