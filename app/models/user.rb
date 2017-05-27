class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email
  validate :is_valid_email

  has_many :authentications, :dependent => :destroy

  def is_valid_email
    email = self.email
    matches = /\w+@\w+.\w+/.match(email)
    unless !(matches.nil?) && matches[0] == email
      errors.add(:email, "is not a valid email")
    end
  end

  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = User.new(
      email: auth_hash["extra"]["raw_info"]["email"]
    )
    user.save!(validate: false)
    user.authentications << (authentication)
    return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end
end
