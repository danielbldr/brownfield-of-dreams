class InviteMailer < ApplicationMailer
  def inform(info, email, sender_name)
    @name = info[:name]
    @email = info[:email]
    @sender_name = sender_name
    mail(to: email, subject: "#{sender_name} would like you to join Brownfield Of Dreams")
  end
end
