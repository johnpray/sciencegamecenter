class UsersController < ApplicationController

	#force_ssl except: :show
  before_filter :signed_in_user,        only: [:edit, :update, :disassociate_omniauth]
  before_filter :block_signed_in_user,  only: [:new, :create]
  before_filter :correct_user,          only: [:edit, :update, :disassociate_omniauth]
  before_filter :admin_user,            only: [:index, :destroy]

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
    @user.disabled = true if @user.is_under_thirteen?
  	if verify_recaptcha(model: @user) && @user.save
      UserMailer.inform_of_signup(@user).deliver
      if @user.disabled? && @user.parent_email
        UserMailer.parent_confirmation(@user).deliver
        flash[:success] = "Your account has been created.
          Please have your parent confirm your account by
          clicking the link in the email they receive from us."
        redirect_to root_path
      else
    		sign_in @user
    		flash[:success] = "You're all signed up!"
    		redirect_to root_path
      end
  	else
  		render 'new'
  	end
  end

  def update
    old_email = @user.email
    flash_message = "Profile and password updated."
    if params[:user][:password].blank?
      if params[:current].present? && params[:current][:password].present?
        params[:user][:password] = params[:current][:password]
      elsif @user.is_oauth?
        @user.dummy_password = true unless current_user.is_admin?
      end
      flash_message = "Profile updated."
    else
      @user.dummy_password = false unless current_user.is_admin?
    end
    if @user.is_oauth? || current_user.is_admin? || @user.authenticate(params[:current][:password])
      if current_user.is_admin?
        @user.attributes = params[:user]
        result = @user.save(validate: false)
      else
        result = @user.update_attributes(params[:user])
      end
      if result
        flash[:success] = flash_message
        sign_in @user unless current_user.is_admin? && !current_user?(@user)
        if @user.email != old_email
          UserMailer.inform_of_email_change(@user, old_email).deliver
        end
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

  # Disassociate any external account
  def disassociate_omniauth
    user = User.find(params[:id])
    if user.remove_omniauth!
      flash[:success] = "That external account has been disassociated from this Science Game Center account. If you didn't have a password, you may need to reset it using 'Forgot Password' the next time you log in."
      redirect_to root_path
    else
      flash[:error] = "There was a problem dissassociating from that external account. Please contact us if this continues to happen and we can sort things out."
      redirect_to root_path
    end
  end

  # Action for sending the parental confirmation email again
  def resend_parent_email
    user = User.find(params[:id])
    if user.disabled?
      UserMailer.parent_confirmation(user).deliver
      flash[:success] = "The confirmation email has been re-sent to your parent or guardian at
        #{user.parent_email}.
        Please have them confirm your account by
        clicking the link in the email they receive from us."
    end
    redirect_to root_path
  end

  # Action for activating a child's account through a link in an email to the parent
  def confirm_child_account
    @user = User.find(params[:id])
    user_code = Digest::MD5::hexdigest(@user.email.downcase)
    url_code = params[:code]
    if @user.disabled? && user_code == url_code
      if @user.update_attribute(:disabled, false)
        flash[:success] = "Thank you! Your child's account has been
          activated. They can now log in with the Email and Password they chose
          when signing up."
          UserMailer.inform_of_activation(@user).deliver
        redirect_to login_path
      else
        flash[:failure] = "There was a problem activating this account.
          Please contact us at <a href='mailto:sciencegamereviews@fas.org'>sciencegamereviews@fas.org</a>".html_safe
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  private

    def block_signed_in_user
      redirect_to root_path if signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) || current_user.is_admin?
    end
end
