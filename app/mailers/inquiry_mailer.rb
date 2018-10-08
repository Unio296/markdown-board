class InquiryMailer < ActionMailer::Base
  
  default from: "info@draftbox"
  default bcc: "unioblog@gmail.com"

  def received_email(inquiry)
    @inquiry = inquiry
    mail(to: @inquiry.email, subject: 'お問い合わせありがとうございます。')
  end
end