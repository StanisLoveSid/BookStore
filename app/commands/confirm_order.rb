class ConfirmOrder < Rectify::Command
  def initialize(order, params, user)
    @order = order
    @params = params[:order]
    @user = user
  end

  def call
    build_order
    @order.valid? ? save_order : write_errors
  end

  private

  def build_order
    @order = OrderForm.from_params @params
  end

  def save_order
    new_order = Order.create @order.to_h
  end

  def write_errors
    @order.errors[:base].concat @order.errors.full_messages
  end
end