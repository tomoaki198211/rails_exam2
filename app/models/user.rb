class User < ApplicationRecord
  has_many :posts
  validates :name, presence: true, length:{ maximum: 30}
  validates :email, presence: true, length:{ maximum: 255},
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true

  before_validation {email.downcase!}
  has_secure_password
  validates :password, length: { minimum: 8 }
  def posts
    return Post.where(user_id: self.id).order("created_at DESC")
  end
end
