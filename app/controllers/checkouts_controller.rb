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
    @user = current_user
    case step
    when :address
      @form = AddressForm.from_params(params)
      AddCheckoutAddresses.call(@form, params)
    when :payment
      @form = CreditCardForm.from_params(params)
      AddCheckoutPayment.call(@form, params)
    when :confirm
      @order.complete
    else
      @order.update(order_params)
    end
    render_wizard @order
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :city, :zipcode, :phone, :country)
  end

  def order_params
    params.require(:order).permit(:delivery_id, :subtotal, :user_id)
  end

end
