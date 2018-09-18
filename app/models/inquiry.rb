class Inquiry
  include ActiveModel::Model

  attr_accessor :name, :email, :message

  validates :name, presence: {message: '名前を入力してください'}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: {message: 'メールアドレスを入力してください'},
                    format: {with: VALID_EMAIL_REGEX, message: 'そのメールアドレスは有効ではありません' }
                    
end