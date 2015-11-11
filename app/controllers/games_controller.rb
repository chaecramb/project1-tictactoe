class GamesController < ApplicationController

  load_and_authorize_resource

  def new
    @game = Game.new
    @users = User.all_except(current_user)
  end

  def index
    redirect_to(new_user_session_path) unless current_user
  end

  def create
    game = Game.create(game_params)
    # game.player1_id = if current_user
    #   current_user.id
    # else 
    #   User.first.id
    # end
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
    @player_2 = User.find(@game.player2_id)
    @symbol = @current_player == @player_1 ? @game.player1_symbol : @game.player2_symbol

    move = Move.create(player_id: @current_player.id ,game_id: params[:id],square: params[:square], value: @symbol)

    @game.moves << move
    @game.update_board

    if @game.moves.size >= 5
      if @game.winning_game?
        @game.winner_id = @game.moves.last.player_id
        winner = User.find(@game.winner_id)
        winner.wins += 1
        winner.points += 3
        winner.save
        loser = User.find(@game.moves.last(2).first.player_id)
        loser.loses += 1
        loser.save
      elsif @game.drawn_game? 
        @game.is_draw = 'true' 
        @player_1.draws += 1
        @player_1.points += 1
        @player_2.draws += 1
        @player_2.points += 1
        @player_1.save
        @player_2.save
      end
    end

    @game.save
    if @game.ai_playing? && !@game.finished?
      @game.load_ai if @game.ai_turn?

      @game.update_board

      if @game.moves.size >= 5
        if @game.winning_game?
          @game.winner_id = @game.moves.last.player_id
          winner = User.find(@game.winner_id)
          winner.wins += 1
          winner.points += 3
          winner.save
          loser = User.find(@game.moves.last(2).first.player_id)
          loser.loses += 1
          loser.save
        elsif @game.drawn_game?
          @game.is_draw = 'true' 
          @player_1.draws += 1
          @player_1.points += 1
          @player_2.draws += 1
          @player_2.points += 1
          @player_1.save
          @player_2.save 
        end
      end

      @game.save
    end

    redirect_to @game
  end






private

  def game_params
    params.require(:game).permit(:player2_id, :id, :square)
  end

end