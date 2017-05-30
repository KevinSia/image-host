class Post < ApplicationRecord
  validates_presence_of :image

  belongs_to :user

  mount_uploader :image, PostImageUploader
end
