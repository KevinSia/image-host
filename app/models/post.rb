class Post < ApplicationRecord
  validates_presence_of :image
  validates_length_of :description, maximum: 1000

  belongs_to :user

  mount_uploader :image, PostImageUploader
end
