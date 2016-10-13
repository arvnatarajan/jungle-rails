class OrderMailerPreview < ActionMailer::Preview

  def order_email
    order = Order.first
    user = User.first
    OrderMailer.order_email(order, user)
  end

end
