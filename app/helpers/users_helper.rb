module UsersHelper

  DEFAULT_SIZE = 50

	# Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_url_for(user, options = { size: DEFAULT_SIZE })
    email = user ? user.email.downcase : "someone"
    gravatar_id = Digest::MD5::hexdigest(email)
    size = options[:size]
    gravatar_url = "//gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=retro"
  end

  def gravatar_for(user, options = { size: DEFAULT_SIZE })
  	gravatar_url = gravatar_url_for(user, options)
    image_tag(gravatar_url, alt: user ? user.name : "someone", class: "gravatar")
  end

  def avatar_url_for(user, options = { size: DEFAULT_SIZE })
    url = gravatar_url_for(user, options)
    url.gsub!(/\A\/\//, "https://") if options[:with_protocol]
    if options[:resolve_redirects]
      url = Net::HTTP.get_response(URI(url))['location']
    end
    url
  end

  def avatar_for(user, options = { size: DEFAULT_SIZE })
    gravatar_for(user, options)
  end
end
