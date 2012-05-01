class GamesController < ApplicationController

  #force_ssl                       except: [:index, :show]
  before_filter :signed_in_user,  except: [:index, :show]
  before_filter :admin_user,      except: [:index, :show]

  def index
    if !params[:platform].blank? || !params[:subject].blank?
      @games = Game.tagged_with("#{params[:platform]}, #{params[:subject]}").paginate(page: params[:page], per_page: 10)
    else
      @games = Game.paginate(page: params[:page], per_page: 10)
    end
  end

  def show
    @game = Game.find(params[:id])
    @player_reviews = @game.player_reviews
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
    if @game.save
      flash[:success] = "Game #{@game.title} created."
      redirect_to @game
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
end
