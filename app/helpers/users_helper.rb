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

  def facebook_pic_url_for(user, options = { size: DEFAULT_SIZE })
    if user.uid.present? && user.provider == 'facebook'
      size = options[:size]
      "//graph.facebook.com/#{user.uid}/picture?width=#{size}&height=#{size}"
    else
      gravatar_url_for(user, options)
    end
  end

  def facebook_pic_for(user, options = { size: DEFAULT_SIZE })
  	if facebook_pic_url = facebook_pic_url_for(user, options)
  		image_tag(facebook_pic_url, alt: user ? user.name : "someone", class: "gravatar facebook-pic", height: options[:size], width: options[:size])
  	else
  		gravatar_for(user, options)
  	end
  end

  def avatar_url_for(user, options = { size: DEFAULT_SIZE })
    url = if user.prefers_gravatar?
      gravatar_url_for(user, options)
    else
      facebook_pic_url_for(user, options)
    end
    url.gsub!(/\A\/\//, "http://") if options[:with_protocol]
    if options[:resolve_redirects]
      url = Net::HTTP.get_response(URI(url))['location']
    end
    url
  end

  def avatar_for(user, options = { size: DEFAULT_SIZE })
  	if user.prefers_gravatar?
      gravatar_for(user, options)
    else
      facebook_pic_for(user, options)
    end
  end
end
