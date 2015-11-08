class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    game = Game.create(game_params)
    game.player1_id = current_user.id
    symbols = ['x','o']
    game.player1_symbol = symbols.shuffle!.pop
    game.player2_symbol = symbols.pop
    game.save
    redirect_to game
  end

  def show
    @game = Game.find(params[:id])
    @current_player = User.find(@game.whose_turn)
    @player_1 = User.find(@game.player1_id)
    @player_2 = User.find(@game.player2_id)

    @symbol = @current_player == @player_1 ? @game.player1_symbol : @game.player2_symbol

    @game.save  
  end

  def update
    @game = Game.find(params[:id])
    @current_player = User.find(@game.whose_turn)
    @player_1 = User.find(@game.player1_id)
    @symbol = @current_player == @player_1 ? @game.player1_symbol : @game.player2_symbol

    @game.moves << Move.create(player_id: @current_player.id ,game_id: params[:id],square: params[:square], value: @symbol)

    @game.update_board
    @game.save

    redirect_to @game
  end






private

  def game_params
    params.require(:game).permit(:player2_id, :id, :square)
  end

end