class GamesController < ApplicationController

  force_ssl                       except: [:index, :show]
  before_filter :signed_in_user,  except: [:index, :show]
  before_filter :admin_user,      except: [:index, :show]

  def index
    @games = Game.paginate(page: params[:page])
  end

  def show
    @game = Game.find(params[:id])
    @player_reviews = @game.player_reviews
    @player_review = PlayerReview.new
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
      flash[:success] = "Game #{@game.title} updated."
      redirect_to @game
    else
      render 'edit'
    end
  end

  def destroy
    game = Game.find(params[:id])
    Game.find(params[:id]).destroy
    flash[:success] = "Game #{game.title} and all its reviews and comments have been destroyed now and forever."
    redirect_to users_path
  end
end
