class Post < ApplicationRecord
  before_create :set_create_slug
  belongs_to :user
  validates :user_id, presence: true #postsはuserが作成する
  
  private
    #slug発行
    def set_create_slug
      loop do
        self.slug = SecureRandom.hex(20)
        break unless Post.where(slug: slug).exists?
      end
    end
  
end
