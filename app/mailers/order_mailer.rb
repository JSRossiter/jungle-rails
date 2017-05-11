class OrderMailer < ApplicationMailer

  def order_email(order)
    @order = order
    mail(to: order.email, subject: 'Jungle - Order Receipt ' + order.id.to_s)
  end
end
