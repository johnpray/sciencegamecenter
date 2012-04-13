class SessionsController < ApplicationController

	force_ssl

	def new
    store_previous_location
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if !user.disabled?
        sign_in user, params[:remember_me]
        flash[:success] = "You've logged in as #{user.name}."
        redirect_back_or root_path
      else
        flash.now[:error] = "Your account is currently disabled.
          If you are waiting for a parent to confirm your account,
          ask them to click the link in the email they received.
          #{ view_context.link_to("Re-send the email",
          resend_parent_email_user_path(user)).html_safe }".html_safe
        render 'new'
      end
    else
      flash.now[:error] = "That email/password combination isn't quite right.
      #{view_context.link_to "Forget your password?", new_password_reset_path}".html_safe
      render 'new'
    end
  end

  def destroy
    store_previous_location
  	sign_out
    flash[:success] = "You've been logged out. #{view_context.link_to "Log in.", login_path}".html_safe
  	redirect_back_or root_path
  end
end
