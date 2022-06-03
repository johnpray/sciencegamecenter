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
    when "reviews_average_total_rating"
      @games = @games.reorder("approved_reviews_average_total_rating DESC, approved_reviews_count DESC, updated_at DESC")
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

  def get_pinned_blog_posts
    if (params[:page].blank? || params[:page] == "1") && params[:topic].blank?
      @pinned_blog_posts = BlogPost.where(pinned: true)

      # Only admins can see unpublished blog_posts
      if !admin?
        @pinned_blog_posts = @pinned_blog_posts.published
      else
        @pinned_blog_posts = @pinned_blog_posts.order("published_at DESC NULLS FIRST, updated_at DESC")
      end

    else
      @pinned_blog_posts = []
    end
  end

  def get_page_of_blog_posts(exclude_pinned: false)
    @blog_posts = BlogPost

    # Only admins can see unpublished blog_posts
    if !admin?
      @blog_posts = @blog_posts.published
    else
      @blog_posts = @blog_posts.order("published_at DESC NULLS FIRST, updated_at DESC")
    end

    # Filter by topic
    @topic = view_context.sanitize(params[:topic])
    if @topic.present?
      @blog_posts = @blog_posts.tagged_with(@topic)
    end

    # Filter by pinned
    if exclude_pinned
      @blog_posts = @blog_posts.where(pinned: false)
    end

    # Paginate
    per_page_number = 10
    if @blog_posts.count < per_page_number+1
      params.delete :page
    end
    @blog_posts = @blog_posts.paginate(page: params[:page], per_page: per_page_number)
  end
end
