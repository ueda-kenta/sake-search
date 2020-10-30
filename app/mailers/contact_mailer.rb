class ContactMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    mail(
      from: '3110testtest@gmail.com',
      to: '3110testtest@gmail.com',
      subject: 'お問い合わせ通知'
    )
  end
end
