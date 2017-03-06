class AddCouponToOrderItem < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :coupon, :integer
  end
end
