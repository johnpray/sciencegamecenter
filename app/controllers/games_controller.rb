class GamesController < ApplicationController

  #force_ssl                       except: [:index, :show]
  before_filter :signed_in_user,  except: [:index, :show]
  before_filter :admin_user,      except: [:index, :show, :new, :create]

  def index    
    get_page_of_games
    
    respond_to do |format|
      format.html
      format.csv { send_data @games.to_csv }
    end
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
end
