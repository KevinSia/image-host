class User < ApplicationRecord
  include PgSearch
  pg_search_scope :search_user, against: [:username, :full_name]

  has_secure_password validations: false

  validates_presence_of :password, if: :validate_password?
  validates_confirmation_of :password, if: :validate_password?
  validates_length_of :password, minimum: 8, maximum: 128, if: :validate_password?

  validates_presence_of :full_name, :email, :authentication_type
  validates_uniqueness_of :email

  validate :is_valid_email

  has_many :authentications, :dependent => :destroy
  has_many :posts

  enum authentication_type: ["email", "facebook"]

  mount_uploader :avatar, AvatarUploader

  def validate_password?
    self.authentication_type == "email"
  end

  def is_valid_email
    email = self.email
    matches = /\w+@\w+.\w+/.match(email)
    unless !(matches.nil?) && matches[0] == email
      errors.add(:email, "is not a valid email")
    end
  end

  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = User.new(
      full_name: auth_hash["extra"]["raw_info"]["name"],
      email: auth_hash["extra"]["raw_info"]["email"],
      authentication_type: 1
    )
    user.save!
    user.authentications << (authentication)
    return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end
end
