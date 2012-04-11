class SessionsController < ApplicationController

	force_ssl

	def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if !user.disabled?
        sign_in user
        redirect_back_or user
      else
        flash.now[:error] = "Your account is currently disabled.
          If you are waiting for a parent to confirm your account,
          ask them to click the link in the email they received.
          #{ view_context.link_to("Re-send the email",
          resend_parent_email_user_path(user)).html_safe }".html_safe
        render 'new'
      end
    else
      flash.now[:error] = "That email/password combination isn't quite right."
      # TODO add Forgot Password link here
      render 'new'
    end
  end

  def destroy
  	sign_out
  	redirect_to root_path
  end
end
