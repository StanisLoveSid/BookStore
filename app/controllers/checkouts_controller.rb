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
      AddCheckoutAddresses.call(@order, params) do
        on(:ok)         { render_wizard @order }
        on(:invalid)    { redirect_to :back }
      end
    when :delivery
      @order.update(order_params)
      if @order.delivery.name == 'none'
        redirect_to :back
      else
        render_wizard @order
      end
    when :payment
      AddCheckoutPayment.call(@order, params) do
        on(:ok)         { render_wizard @order }
        on(:invalid)    { redirect_to :back }
      end
    when :confirm
      OrderMailer.send_order(@order, current_user).deliver
      @order.complete
      render_wizard @order
    end
  end

  private

  def order_params
    params.require(:order).permit(:delivery_id, :subtotal, :user_id)
  end

end
