class UpdateOrder < Rectify::Command
  def initialize(order, params)
    @order = order
    @params = params[:order][:order_items]
  end

  def call
    build_credit_card
    @credit_card.valid? ? save_card : write_errors
    return broadcast(:invalid) if write_errors.any?
    broadcast(:ok)
  end

  private

  def build_credit_card
    @credit_card = OrderForm.from_params @params
  end

  def save_card
    new_card = @order.update @credit_card.to_h
  end

  def write_errors
    @order.errors[:base].concat @credit_card.errors.full_messages
  end
end