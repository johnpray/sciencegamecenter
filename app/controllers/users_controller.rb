class UsersController < ApplicationController

	force_ssl except: :show

	def show
		@user = User.find(params[:id])
	end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		sign_in @user
  		flash[:success] = "You're all signed up!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:password].empty?
      params[:user][:password] = params[:current][:password]
    end
    if @user.authenticate(params[:current][:password])
      if @user.update_attributes(params[:user])
        flash[:success] = "Profile updated."
        sign_in @user
        redirect_to @user
      else
        render 'edit'
      end
    else
      flash.now[:error] = "Your current password was wrong. Try again."
      render 'edit'
    end
  end
end
