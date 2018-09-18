class InquiryMailer < ActionMailer::Base
  
  default from: "info@draftbox"
  # default to: "送信先"

  def received_email(inquiry)
    @inquiry = inquiry
    mail(to: @inquiry.email, subject: 'お問い合わせありがとうございます。')
  end
end