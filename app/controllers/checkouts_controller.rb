class CheckoutsController < ApplicationController

  include Rectify::ControllerHelpers
  include Wicked::Wizard
  steps :address, :delivery, :payment, :confirm, :complete
  before_action :authenticate_user!
  before_action :set_step


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
        on(:ok) do

          if @order.filled?
            redirect_to(checkout_path(:confirm))
          else
            render_wizard @order
          end
        end
        on(:invalid) do
          render_wizard
        end
      end
    when :delivery
      @order.update(order_params)
      if @order.delivery.name == 'none'
        render_wizard
      else
        if @order.filled?
          redirect_to(checkout_path(:confirm))
        else
          render_wizard @order
        end
      end
    when :payment
      AddCheckoutPayment.call(@order, params) do
        on(:ok)  do
          @order.aasm.current_state = :filled
          render_wizard @order
        end
        on(:empty_address) {redirect_to(checkout_path(:address))}
        on(:empty_delivery) {redirect_to(checkout_path(:delivery))}
        on(:invalid)    { render_wizard }
      end
    when :confirm
      OrderMailer.send_order(@order, current_user).deliver
      @order.complete
      render_wizard @order
    end
  end

  private

  def set_step
    case step
    when :confirm
      redirect_to root_path if !current_order.filled?
    end
  end

  def order_params
    params.require(:order).permit(:delivery_id, :subtotal, :user_id)
  end

end
