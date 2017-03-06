class AddCheckoutAddresses < Rectify::Command
  def initialize(order, params)
    @order = order
    @params = params
  end

  def call
    set_billing
    @billing.valid? ? save_billing : write_errors(:billing, @billing)

    set_shipping
    @shipping.valid? ? save_shipping : write_errors(:shipping, @shipping)
  end

  private

  def set_billing
    @billing = AddressForm.from_params(@params[:billing])
  end

  def save_billing
    Address.create @billing.address
  end

  def set_shipping
    @shipping = use_billing? ? @billing : shipping_from_params
    @shipping.address[:addressable_type] = 'order_shipping'
  end

  def use_billing?
    @params[:order][:use_billing][:allow] == '1'
  end

  def shipping_from_params
    AddressForm.from_params(@params[:shipping])
  end

  def save_shipping
    Address.create @shipping.address
  end

  def write_errors(type, address)
    @order.errors[type].concat address.errors.full_messages
  end
end
