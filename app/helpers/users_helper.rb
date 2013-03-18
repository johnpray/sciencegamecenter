module UsersHelper

	# Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 })
  	email = user ? user.email.downcase : "someone"
    gravatar_id = Digest::MD5::hexdigest(email)
    size = options[:size]
    gravatar_url = "//gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=retro"
    image_tag(gravatar_url, alt: user ? user.name : "someone", class: "gravatar")
  end

  def facebook_pic_for(user, options = { size: 50 })
  	if user.uid.present? && user.provider == 'facebook'
  		facebook_pic_url = "//graph.facebook.com/#{user.uid}/picture?type=square"
  		image_tag(facebook_pic_url, alt: user ? user.name : "someone", class: "gravatar facebook-pic", height: options[:size], width: options[:size])
  	else
  		gravatar_for(user, options)
  	end
  end

  def avatar_for(user, options = { size: 50 })
  	if user.prefers_gravatar?
  		gravatar_for(user, options)
  	else
  		facebook_pic_for(user, options)
  	end
  end
end
