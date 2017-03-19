module CheckoutsHelper
  def fill_address(user, order, type, field)
    order.public_send("order_#{type}").try(field) || user.public_send(type).try(field)
  end
end
