class BlogPostsController < ApplicationController
  before_filter :signed_in_user,  except: [:index, :show]
  before_filter :admin_user,      except: [:index, :show]

  def index
    get_page_of_blog_posts
  end

  def show
    find_blog_post
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    fix_published_at_timezone
    @blog_post = BlogPost.new(params[:blog_post])
    if @blog_post.save
      flash[:success] = "Blog Post created."
      redirect_to @blog_post
    else
      render :new
    end
  end

  def edit
    find_blog_post
  end

  def update
    fix_published_at_timezone
    find_blog_post
    if @blog_post.update(params[:blog_post])
      flash[:success] = "Blog Post updated."
      redirect_to @blog_post
    else
      render :edit
    end
  end

  def destroy
    find_blog_post
    @blog_post.destroy!
    flash[:success] = "Blog post \"#{@blog_post.title}\" destroyed."
    redirect_to blog_posts_path
  end

  private

  def find_blog_post
    if admin?
      @blog_post = BlogPost.find(params[:id])
    else
      @blog_post = BlogPost.published.find(params[:id])
    end
  end

  def get_page_of_blog_posts
    @blog_posts = BlogPost

    # Only admins can see unpublished blog_posts
    @blog_posts = @blog_posts.published unless admin?

    # Filter by topic
    @topic = view_context.sanitize(params[:topic])
    if @topic.present?
      @blog_posts = @blog_posts.tagged_with(@topic)
    end

    # Paginate
    per_page_number = 10
    if @blog_posts.count < per_page_number+1
      params.delete :page
    end
    @blog_posts = @blog_posts.paginate(page: params[:page], per_page: per_page_number)
  end

  def fix_published_at_timezone
    Rails.logger.debug "params[:blog_post][:published_at]: #{params[:blog_post][:published_at]}"
    if params[:blog_post][:published_at].present?
      Time.zone = "Eastern Time (US & Canada)"
      params[:blog_post][:published_at] = Time.zone.parse(params[:blog_post][:published_at])
      Rails.logger.debug "params[:blog_post][:published_at]: #{params[:blog_post][:published_at]}"
    end
  end
end
