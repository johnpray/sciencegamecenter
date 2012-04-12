class GamesController < ApplicationController

  force_ssl                       except: [:index, :show]
  before_filter :signed_in_user,  except: [:index, :show]
  before_filter :admin_user,      except: [:index, :show]

  def index
    @games = Game.paginate(page: params[:page])
  end

  def show
    @game = Game.find(params[:id])
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
  end

  def update
    if @game.update_attributes(params[:game])
      flash[:success] = "Game #{@game.title} updated."
      redirect_to @game
    else
      render 'edit'
    end
  end

  def destroy
  end
end
