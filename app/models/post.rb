class Post < ApplicationRecord

  belongs_to :user, optional: true
  mount_uploader :picture, PictureUploader
  validates :content, presence: true

  def user
    return User.find_by(id: self.user_id)
  end

end
