class AddCheckoutPayment < Rectify::Command
  def initialize(order, params)
    @order = order
    @params = params[:order][:credit_card_attributes]
  end

  def call
    build_credit_card
    save_card if @credit_card.valid?
    return broadcast(:invalid) if write_errors.any?
    return broadcast(:empty_address) if @order.order_billing.nil?
    return broadcast(:empty_delivery) if @order.delivery.name == 'none'
    broadcast(:ok)
  end

  private

  def build_credit_card
    @credit_card = CreditCardForm.from_params @params
  end

  def save_card
    new_card = CreditCard.create @credit_card.to_h
    new_card.orders << @order
  end

  def write_errors
    @order.errors[:base].concat @credit_card.errors.full_messages
  end
end
