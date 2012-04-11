class PasswordResetsController < ApplicationController
  def new
  end

  def create
  	if user = User.find_by_email(params[:email])
  		user.send_password_reset
  		flash[:success] = "Check your email for instructions on resetting your password."
  		redirect_to root_path
  	else
  		flash.now[:failure] = "No user account with that email address exists."
  		render 'new'
  	end
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  	@user = User.find_by_password_reset_token!(params[:id])
  	if @user.password_reset_sent_at < 2.hours.ago
  		flash[:failure] = "That password reset link has expired. Try again."
  		redirect_to new_password_reset_path
  	elsif @user.update_attributes(params[:user])
  		flash[:success] = "New password created successfully. Now use it to log in."
  		redirect_to login_path
		else
			render 'edit'
		end
  end
end
