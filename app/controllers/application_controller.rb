class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def user_for_paper_trail
    current_user ? current_user.id : nil
  end
  
  private
  
  def get_page_of_games
    @games = Game

    # Only admins can see disabled games
    @games = @games.enabled unless admin?

    # Filter by category
    category_types = [:subject, :platform, :cost, :intended_for, :developer_type]
    if @any_category_defined = any_category_defined?
      @games = @games.tagged_with(category_types.map {|c| params[c]}.join(", "))
    end

    # Filter by title
    if params[:title].present?
      verb = Rails.env.development? ? "LIKE" : "ILIKE"
      @games = @games.where("title #{verb} ?", "%#{params[:title]}%")
    end

    # Order
    case params[:order_by]
    when "updated_at"
      @games = @games.reorder("updated_at DESC")
    when "reviews_count"
      @games = @games.reorder("approved_reviews_count DESC, updated_at DESC")
    when "created_at"
      @games = @games.reorder("created_at DESC")
    when "title"
      @games = @games.reorder("title ASC")
    else
      @games = @games.reorder("updated_at DESC")
    end

    # Paginate
    unless request.format.csv?
      per_page_number = 10
      if @games.count < per_page_number+1
        params.delete :page
      end
      @games = @games.paginate(page: params[:page], per_page: per_page_number)
    end
  end
  
  def any_category_defined?
    params[:platform].present? || params[:subject].present? || params[:cost].present? || params[:intended_for].present? || params[:developer_type].present?
  end
end
