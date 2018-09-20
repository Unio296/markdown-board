class User < ApplicationRecord

  has_many :posts, dependent: :destroy  #userが削除されると所有しているpostsも削除される

  #twitter認証
  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    nickname = auth[:info][:nickname]
    image_url = auth[:info][:image]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.nickname = nickname
      user.image_url = image_url
    end
  end
end
