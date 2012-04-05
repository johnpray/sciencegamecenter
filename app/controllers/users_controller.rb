class UsersController < ApplicationController

	force_ssl except: :show
  before_filter :signed_in_user,  only: [:edit, :update]
  before_filter :correct_user,    only: [:edit, :update]
  before_filter :admin_user,      only: [:index, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

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

  def destroy
    user = User.find(params[:id])
    if current_user?(user)
      flash[:error] = "Sorry, but you can't destroy your own account."
      redirect_to users_path
    else
      User.find(params[:id]).destroy
      flash[:success] = "User #{user.name} (#{user.email}) has been destroyed now and forever...unless they sign up again."
      redirect_to users_path
    end
  end

  private

    def signed_in_user
      store_location
      redirect_to login_path, notice: "Please log in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.is_admin?
    end
end
