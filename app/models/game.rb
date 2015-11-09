class Game < ActiveRecord::Base
  has_many :moves
  has_and_belongs_to_many :users

  validates :player1_symbol, inclusion: { in: %w(o x) }
  validates :player2_symbol, inclusion: { in: %w(o x) }

  WINNING_LINES = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]

  def available_spaces
    ((0..8).to_a - Move.where(game_id: id).pluck(:square))
  end

  def finished?
    !!(self.winner_id || self.is_draw)
  end

  def ai_playing?
    player1_id == 2 || player2_id == 2 || player1_id == 4 || player2_id == 4
  end

  def ai_symbol
    ((player1_id == 2) || (player1_id == 4)) ? player1_symbol : player2_symbol
  end

  def ai_move
    available_spaces.sample
  end

  def load_ai
    ai_id = self.whose_turn
    if ai_id == 2
      @move = Move.create(player_id: 2 ,game_id: id,square: ai_move, value: ai_symbol)
    end

    if ai_id == 4

      @move = minmax(ai_symbol)
    end

    self.moves << @move

  end

  def score(potential_board)
    if winning_symbol(potential_board) == ai_symbol
      return 10
    elsif winning_symbol(potential_board) == switch(ai_symbol)
      return -10
    end
    0
  end

  def switch(symbol)
    symbol == 'x' ? 'o' : 'x'
  end

  def game_over?(potential_board)
    # board.winner || board.tie?
    # this line hasn't been changed yet
  end

  def minmax(current_symbol, potential_board = nil )
    # return score potential_board if game_over? potential_board
    # make above work
    scores = {}
    available_spaces.each do |space|
      potential_board = board.dup
      potential_board[space] = current_symbol
      binding.pry
      # below results in stack level too deep
      scores[space] = minmax(switch(current_symbol),potential_board)
    end
     

    @best_move = best_move current_symbol, scores
  end

  def ai_turn?
    self.whose_turn == 2 || self.whose_turn == 4
  end

  def whose_turn
    return player1_id if moves.empty?
    moves.last.player_id == player1_id ? player2_id : player1_id
  end

  def make_move(options = {})
    moves << Move.new(square: options[:square], player_id: options[:player_id], value: options[:value], game_id: options[:game_id])
    board[options[:square]] = options[:value]
  end

  def update_board
    moves.each do |move|
      board[move.square] = move.value
    end
  end

  # private
  def winning_game?
    !!WINNING_LINES.detect do |winning_line|
      (winning_line & moves.where(player_id: moves.last.player_id).pluck(:square)).size == 3
    end  
  end

  # private
  def drawn_game?
    board.all?
  end

  def winning_symbol(potential_board)
    return 'x' if WINNING_LINES.any? { |line| line.all? { |square| potential_board[square] == 'x' } }
    return 'o' if WINNING_LINES.any? { |line| line.all? { |square| potential_board[square] == 'o' } }
  end

end
