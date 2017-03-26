class OrdersController < ApplicationController

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to "/cart"
  end

  def create
    CreateOrder.call(params) do
      on(:ok)       { redirect_to cart_path }
      on(:invalid)  {  }
    end
  end

  def edit
    @items = current_order.order_items
    @order_items = @items.sort_by(&:quantity).reverse
    @order = current_order
  end

  def show
    @user = current_user
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
      @status = "Select sorting"
    end
  end

  private

  def order_params
    params.require(:order).permit(:subtotal, :coupon, 
      order_items_attributes: [:id, :quantity, :book_id])
  end
end
