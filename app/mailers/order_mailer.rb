class OrderMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def order_email(order, user)
    @order = order
    @user = user
    @url = "http://localhost:3000/orders/#{@order.id}"
    mail(to: @order.email, subject: "Thanks for your order! Order ID: #{@order.id}")
  end

end
