require 'single_sign_on'

class SsoController < ApplicationController

  before_filter :signed_in_user

  def discourse
    if current_user.needs_forum_approval?
      redirect_to forum_approval_path
    else
      secret = ENV['DISCOURSE_SSO_SECRET']
      sso = SingleSignOn.parse(request.query_string, secret)
      sso.email = current_user.email
      sso.name = current_user.name
      sso.username = current_user.name
      sso.external_id = current_user.id
      sso.sso_secret = secret
      if (avatar_url = view_context.avatar_url_for(current_user, size: 120, with_protocol: true, resolve_redirects: true)).present?
        sso.avatar_url = avatar_url
        sso.avatar_force_update = true
      end

      redirect_to sso.to_url("http://forum.sciencegamecenter.org/session/sso_login")
    end
  end

end
