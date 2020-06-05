class SessionsController < ApplicationController

	def new
    location_stored? || store_previous_location
  end

  def create
    if (auth = env['omniauth.auth']).present? # Logging in with Facebook
      # raise env['omniauth.auth'].to_yaml # uncomment this to see facebook's raw response

      unless auth.info.email.present? && auth.extra.raw_info.birthday.present?
        flash[:error] = "You must grant permission for
          your email address and birth date in order to log in using Facebook."
        redirect_to new_session_path
        return
      end

      user = User.from_omniauth(auth, @current_user)
      authenticated = true if user
      omniauth = true
    else # Logging in with email and password
      user = User.find_by_email(params[:session][:email])
      authenticated = user && user.authenticate(params[:session][:password])
      remember_me = params[:remember_me]
    end
    if authenticated
      if !user.disabled?
        sign_in user, remember_me, omniauth
        flash[:success] = "You've logged in as #{view_context.link_to user.name, user}.".html_safe
        redirect_back_or root_path
      else
        if !user.parent_email.blank?
          flash.now[:error] = "Your account is currently disabled.
            If you are waiting for a parent to confirm your account,
            ask them to click the link in the email they received.
            #{ view_context.link_to("Re-send the email",
            resend_parent_email_user_path(user)).html_safe }".html_safe
        else
          flash.now[:error] = "Your account is currently disabled."
        end
        render 'new'
      end
    else
      if omniauth
        flash[:error] = "There was a problem logging you in."
        redirect_to root_path
      else
        flash.now[:error] = "That email/password combination isn't quite right.
        #{view_context.link_to "Forget your password?", new_password_reset_path}".html_safe
        render 'new'
      end
    end
  end

  def destroy
    log_out_discourse_sso
  	sign_out
    flash[:success] = "You've been logged out. #{view_context.link_to "Log in.", login_path}".html_safe
  	redirect_to root_path
  end

  private

  def log_out_discourse_sso
    discourse_endpoint = RestClient::Resource.new("http://forum.sciencegamecenter.org")
    discourse_user_json = discourse_endpoint["/users/by-external/#{current_user.id}.json"].get
    discourse_user_id = JSON.parse(discourse_user_json)["user"]["id"]
    discourse_endpoint["/admin/users/#{discourse_user_id}/log_out"].post(nil)
    # TODO: This currently doesn't work, I think due to a Discourse bug with csrf tokens.
    # Try modifying Discourse later, and submit a pull request.
  rescue => e
    if e.is_a? RestClient::ResourceNotFound
      # User doesn't exist on Discourse
    else
      # raise unless Rails.env.production?
      Rails.logger.error "Couldn't log out Discourse account for SGC user #{current_user.id}:\n  #{e.class}: #{e.message}"
    end
  end
end
