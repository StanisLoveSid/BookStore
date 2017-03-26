class CreateOrder < Rectify::Command
  def initialize(params)
    @book_id = params[:book_id].to_i
    @quantity = params[:quantity].to_i
  end

  def call
    return broadcast(:invalid) unless @book_id && @quantity
    transaction do
      add_item_to_order
    end
    broadcast :ok
  end

  private

  def add_item_to_order
    order_in_progress.add_item(@book_id, @quantity)
    order_in_progress.save
  end

  def order_in_progress
    current_customer.orders.in_progress.first || current_customer.orders.create
  end
end