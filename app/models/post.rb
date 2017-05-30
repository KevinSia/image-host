class Post < ApplicationRecord
  validates_presence_of :image
  validates_length_of :description, maximum: 1000

  belongs_to :user
  has_and_belongs_to_many :albums

  mount_uploader :image, PostImageUploader
end
