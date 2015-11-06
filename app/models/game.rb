class Game < ActiveRecord::Base
  has_many :moves

  WINNING_LINES = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]

  def finished?
    !!(self.winner_id || self.is_draw)
  end

  def whose_turn
    return player1_id if moves.empty?
    moves.last.player_id == player1_id ? player2_id : player1_id
  end

  def make_move(options = {})
    moves << Move.new(square: options[:square], player_id: options[:player_id], value: options[:value], game_id: options[:game_id])
  end

  private
  # def winning_game?
  #   !!WINNING_LINES.detect do |winning_line|
  #     %w(XXX OOO).include?(winning_line.map { |e| board_symbols[e] }.join)
  #   end
  # end

  private
  def drawn_game?
    board.all?
  end

end
