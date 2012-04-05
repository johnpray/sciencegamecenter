class UsersController < ApplicationController

	force_ssl except: :show
  before_filter :signed_in_user,  only: [:edit, :update]
  before_filter :correct_user,    only: [:edit, :update]

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
  end

  def update
    flash_message = "Profile and password updated."
    if params[:user][:password].empty?
      params[:user][:password] = params[:current][:password]
      flash_message = "Profile updated."
    end
    if @user.authenticate(params[:current][:password])
      if @user.update_attributes(params[:user])
        flash[:success] = flash_message
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

  private

    def signed_in_user
      redirect_to login_path, notice: "Please log in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
