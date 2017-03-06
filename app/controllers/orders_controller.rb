class OrdersController < ApplicationController

  def update
  	@order = Order.find(params[:id])
  	@order.update(order_params)
  	redirect_to "/cart"
  end

  def create
  	@order = Order.find(params[:id])
  	@order.new(order_params)
  	@order.save
  	redirect_to "/cart"
  end

  def edit
  	@order_items = current_order.order_items
  	@order = current_order
  end

  private

  def order_params
    params.require(:order).permit(:subtotal, :coupon)
  end
end
