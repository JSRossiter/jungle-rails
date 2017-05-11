class OrderMailer < ApplicationMailer

  def order_email(order)
    @email = 'rossiter.jeffrey@gmail.com'
    @order = order
    mail(to: @email, subject: 'Jungle - Order Receipt ' + order.id.to_s)
  end
end
