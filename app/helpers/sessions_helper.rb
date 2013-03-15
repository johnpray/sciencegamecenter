module SessionsHelper
	
	def sign_in(user, remember_me = false, omniauth = false)
    if remember_me
      cookies.permanent[:remember_token] = user.remember_token
    elsif omniauth && user.oauth_expires_at.present?
      cookies[:remember_token] = {value: user.remember_token, expires: user.oauth_expires_at}
    else
      cookies[:remember_token] = user.remember_token
    end
    current_user = user
  end

  def signed_in?
  	!current_user.nil?
  end

  def admin?
    signed_in? && current_user.is_admin?
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

  def store_previous_location
    session[:return_to] = request.env['HTTP_REFERER'] || root_path
  end

  def location_stored?
    !session[:return_to].blank?
  end

  private

  	def user_from_remember_token
  		remember_token = cookies[:remember_token]
      unless remember_token.nil?
    		user = User.find_by_remember_token(remember_token)
        if user && !user.disabled?
          user
        else
          nil
        end
      end
  	end

    def clear_return_to
      session.delete(:return_to)
    end
end
