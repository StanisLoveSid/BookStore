class OrderMailer < ActionMailer::Base
	def send_order(order, user)
		@order = order
		@user = user
		@order_items = @order.order_items
		recipients = [@user.email, "joingamings@gmail.com"]
       	mail(to: recipients, 
       		from: 'forumjankenpon@gmail.com',
       		subject: "Order #{@order.number} completed")
	end
end