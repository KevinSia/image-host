class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email
  validates_length_of :password, minimum: 8
  validate :is_valid_email

  def is_valid_email
    email = self.email
    matches = /\w+@\w+.\w+/.match(email)
    unless !(matches.nil?) && matches[0] == email
      errors.add(:email, "is not a valid email")
    end
  end
end
