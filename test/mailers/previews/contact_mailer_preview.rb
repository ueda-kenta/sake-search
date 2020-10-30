# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def inquiry
    contact = Contact.new(message: '問い合わせメッセージ')

    ContactMailer.send_mail(contact)
  end
end
