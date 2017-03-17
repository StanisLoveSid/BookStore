class AddDaysToDelivery < ActiveRecord::Migration[5.0]
  def change
    add_column :deliveries, :days, :string
  end
end
