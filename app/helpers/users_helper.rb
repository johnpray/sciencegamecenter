module UsersHelper

	# Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 })
  	email = user ? user.email.downcase : "someone"
    gravatar_id = Digest::MD5::hexdigest(email)
    size = options[:size]
    gravatar_url = "//gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    image_tag(gravatar_url, alt: user ? user.name : "someone", class: "gravatar")
  end
end
