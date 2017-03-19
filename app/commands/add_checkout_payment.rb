class AddCheckoutPayment < Rectify::Command
  def initialize(order, params, user)
    @order = order
    @params = params[:order][:credit_card_attributes]
    @user = user
  end

  def call
    build_credit_card
    @credit_card.valid? ? save_card : write_errors
  end

  private

  def build_credit_card
    @credit_card = CreditCardForm.from_params @params
  end

  def save_card
    new_card = CreditCard.create @credit_card.to_h
    @user.orders << @order
  end

  def write_errors
    @order.errors[:base].concat @credit_card.errors.full_messages
  end
end