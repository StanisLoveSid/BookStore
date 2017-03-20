class CheckoutsController < ApplicationController

  include Rectify::ControllerHelpers
  include Wicked::Wizard
  steps :address, :delivery, :payment, :confirm, :complete
  before_action :authenticate_user!

  def show
    @user = current_user
    @order = current_order
    render_wizard
  end

  def update
    @order = current_order
    case step
    when :address
      AddCheckoutAddresses.call(@order, params)
    when :payment
      AddCheckoutPayment.call(@order, params, current_user)
    when :confirm
      OrderMailer.send_order(@order, current_user).deliver
      @order.complete
    else
      @order.update(order_params)
    end
    render_wizard @order
  end

  private

  def order_params
    params.require(:order).permit(:delivery_id, :subtotal, :user_id)
  end

end
