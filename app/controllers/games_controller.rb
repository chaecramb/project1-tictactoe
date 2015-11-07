class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    game = Game.create(game_params)
    game.player1_id = current_user.id
    game.save
    redirect_to game
  end

  def show
    @game = Game.find(params[:id])
    @current_player = @game.whose_turn
    @player_1 = User.find(@game.player1_id)
    @player_2 = User.find(@game.player2_id)


  
    @game.save  
  end






private

  def game_params
    params.require(:game).permit(:player2_id)
  end

end