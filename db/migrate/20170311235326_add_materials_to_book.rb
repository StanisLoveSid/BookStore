class AddMaterialsToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :year_of_publication, :integer
    add_column :books, :demensions, :string
    add_column :books, :materials, :string
  end
end
