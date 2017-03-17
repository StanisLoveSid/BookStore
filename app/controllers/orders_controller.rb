class OrdersController < ApplicationController

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to "/cart"
  end

  def create
    @order = current_user.orders.find(params[:id])
    @order.new(order_params)
    @order.save
    redirect_to "/cart"
  end

  def edit
    @order_items = current_order.order_items
    @order = current_order
  end

  def show
    @order = Order.find(params[:id])
  end

  def index
    @user_orders = current_user.orders
    if params[:filter] == 'All'
      @orders = @user_orders
      @status = 'All'
    elsif params[:filter] == 'Waiting for processing'
      @orders = @user_orders.in_queue
      @status = "Waiting for processing"
    elsif params[:filter] == 'In delivery'
      @orders = @user_orders.in_delivery
      @status = "In delivery"
    elsif params[:filter] == 'Delivered'
      @orders = @user_orders.delivered
      @status = "Delivered"
    else 
      @orders = @user_orders
    end
  end

  private

  def order_params
    params.require(:order).permit(:subtotal, :coupon)
  end
end
