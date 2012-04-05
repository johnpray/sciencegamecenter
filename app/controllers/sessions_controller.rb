class SessionsController < ApplicationController

	force_ssl

	def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = "That email/password combination isn't quite right." # TODO add Forgot Password link here
      render 'new'
    end
  end

  def destroy
  	sign_out
  	redirect_to root_path
  end
end
