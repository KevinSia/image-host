module UsersHelper
  def user_avatar(user, version=nil, options={})
    version_options = get_version_preset(version)
    version_options.merge!(options)
    user.avatar? ? image_tag(user.avatar_url, version_options) : image_tag("default-avatar-#{version}.png", options)
  end

  private
  def get_version_preset(version)
    case version
    when :small
      {width: 48, height: 48}
    else
      {}
    end
  end
end
