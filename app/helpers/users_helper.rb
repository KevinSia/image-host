module UsersHelper
  def user_avatar(user, options={})
    user.avatar? ? image_tag(user.avatar_url, options) : image_tag("http://placehold.it/32x32", options)
  end
end
