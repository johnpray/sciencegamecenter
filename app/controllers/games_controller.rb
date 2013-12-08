class GamesController < ApplicationController

  #force_ssl                       except: [:index, :show]
  before_filter :signed_in_user,  except: [:index, :show]
  before_filter :admin_user,      except: [:index, :show, :new, :create]

  def index
    category_types = [:subject, :platform, :cost, :intended_for, :developer_type]
    per_page_number = 10
    @any_category_defined = any_category_defined?
    if @any_category_defined
      if admin?
        @games = Game.tagged_with(category_types.map {|c| params[c]}.join(", "))
        if @games.count < per_page_number+1
          params.delete :page
          @games = Game.tagged_with(category_types.map {|c| params[c]}.join(", "))
        end
      else
        @games = Game.enabled.tagged_with(category_types.map {|c| params[c]}.join(", "))
        if @games.count < per_page_number+1
          params.delete :page
          @games = Game.enabled.tagged_with(category_types.map {|c| params[c]}.join(", "))
        end
      end
    else
      if admin?
        @games = Game
        if @games.count < per_page_number+1
          params.delete :page
          @games = Game
        end
      else
        @games = Game.enabled
        if @games.count < per_page_number+1
          params.delete :page
          @games = Game.enabled
        end
      end
    end
    verb = Rails.env.development? ? "LIKE" : "ILIKE"
    @games = @games.where("title #{verb} ?", "%#{params[:title]}%") if params[:title].present?
    @games = @games.paginate(page: params[:page], per_page: per_page_number)
  end

  def show
    @game = Game.find(params[:id])

    if @game.disabled? && !admin?
      flash[:failure] = "Swiper, no swiping! Sorry, you aren't able to view that page unless you're a site administrator."
      redirect_to root_path
    end

    @player_reviews = @game.actual_player_reviews
    @expert_reviews = @game.expert_reviews
    @authoritative_reviews = @game.authoritative_reviews
    @player_review = PlayerReview.new

    if request.path != game_path(@game)
      redirect_to @game, status: :moved_permanently
    end
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(params[:game])
    @game.user = current_user
    if @game.save
      if admin?
        flash[:success] = "Game #{@game.title} created."
        redirect_to @game
      else
        GameMailer.notify_of_new_game(@game).deliver
        flash[:success] = view_context.sanitize "Your game <i>#{@game.title}</i> has been submitted and will be considered by the SGC Team. Thanks!"
        redirect_to games_path
      end
    else
      render 'new'
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(params[:game])
      flash[:success] = view_context.sanitize "Game <i>#{@game.title}</i> updated."
      redirect_to @game
    else
      render 'edit'
    end
  end

  def destroy
    game = Game.find(params[:id])
    Game.find(params[:id]).destroy
    flash[:success] = view_context.sanitize "Game <i>#{game.title}</i> and all its reviews and comments have been destroyed now and forever."
    redirect_to games_path
  end

  private

  def any_category_defined?
    params[:platform].present? || params[:subject].present? || params[:cost].present? || params[:intended_for].present? || params[:developer_type].present?
  end
end
