class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def user_for_paper_trail
    current_user ? current_user.id : nil
  end
end
