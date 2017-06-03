class Album < ApplicationRecord
  validates_length_of :title, minimum: 1, maximum: 100
  belongs_to :user
  has_and_belongs_to_many :posts

  validate :belongs_to_correct_user

  # prevent users from adding others images into their albums
  def belongs_to_correct_user
    self.posts.each do |x|
      next if x.user_id == self.user_id
      self.errors.add(:user_id, "does not match the current_user")
      return false
    end
  end
end
