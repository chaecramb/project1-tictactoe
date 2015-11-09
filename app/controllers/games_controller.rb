class GamesController < ApplicationController

  load_and_authorize_resource

  def new
    @game = Game.new
  end

  def create
    game = Game.create(game_params)
    game.player1_id = current_user.id
    game.users << player_1 = User.find(game.player1_id)
    game.users << player_2 = User.find(game.player2_id)
    symbols = ['x','o']
    game.player1_symbol = symbols.shuffle!.pop
    game.player2_symbol = symbols.pop
    game.save
    player_1.save
    player_2.save
    redirect_to game
  end

  def show
    @game = Game.find(params[:id])
    @player_1 = User.find(@game.player1_id)
    @player_2 = User.find(@game.player2_id)
    @current_player = User.find(@game.whose_turn)
    @winner = User.find(@game.winner_id) if @game.winner_id

    unless @game.finished?
    

      @symbol = @current_player == @player_1 ? @game.player1_symbol : @game.player2_symbol

      @game.save 
    end 
  end

  def update
    @game = Game.find(params[:id])
    @current_player = User.find(@game.whose_turn)
    @player_1 = User.find(@game.player1_id)
    @symbol = @current_player == @player_1 ? @game.player1_symbol : @game.player2_symbol

    move = Move.create(player_id: @current_player.id ,game_id: params[:id],square: params[:square], value: @symbol)

    @game.moves << move
    @game.update_board

    if @game.moves.size >= 5
      if @game.winning_game?
        @game.winner_id = @game.moves.last.player_id
      else
        @game.is_draw = 'true' if @game.drawn_game? 
      end
    end
    @game.save

    redirect_to @game
  end






private

  def game_params
    params.require(:game).permit(:player2_id, :id, :square)
  end

end