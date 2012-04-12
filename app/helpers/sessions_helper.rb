module SessionsHelper
	
	def sign_in(user, remember_me = false)
    if remember_me
      cookies.permanent[:remember_token] = user.remember_token
    else
      cookies[:remember_token] = user.remember_token
    end
    current_user = user
  end

  def signed_in?
  	!current_user.nil?
  end

  def current_user=(user)
  	@current_user = user
  end

  def current_user
  	@current_user ||= user_from_remember_token
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to login_path, notice: "Please log in first."
    end
  end

  def admin_user
    redirect_to(root_path) unless current_user.is_admin?
  end

  def sign_out
  	current_user = nil
  	cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  private

  	def user_from_remember_token
  		remember_token = cookies[:remember_token]
      unless remember_token.nil?
    		user = User.find_by_remember_token(remember_token)
        user unless user.disabled?
      end
  	end

    def clear_return_to
      session.delete(:return_to)
    end
end
