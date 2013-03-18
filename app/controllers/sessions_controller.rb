class SessionsController < ApplicationController

	#force_ssl

	def new
    location_stored? || store_previous_location
  end

  def create
    if env['omniauth.auth'].present? # Logging in with Facebook
      user = User.from_omniauth(env['omniauth.auth'], @current_user)
      authenticated = true if user
      omniauth = true
      #raise env['omniauth.auth'].to_yaml # uncomment this to see facebook's raw response
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
  	sign_out
    flash[:success] = "You've been logged out. #{view_context.link_to "Log in.", login_path}".html_safe
  	redirect_to root_path
  end
end
