module UsersHelper
  def user_avatar(user, version=nil, options={})
    user.avatar? ? image_tag(user.avatar_url(version), options) : image_tag("default-avatar-#{version}.png", options)
  end
end
