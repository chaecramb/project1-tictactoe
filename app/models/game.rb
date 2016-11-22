class Game < ActiveRecord::Base
  has_many :moves
  has_and_belongs_to_many :users

  validates :player1_symbol, inclusion: { in: %w(o x) }
  validates :player2_symbol, inclusion: { in: %w(o x) }

  WINNING_LINES = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]

  EMPTY_BOARD = [nil,nil,nil,nil,nil,nil,nil,nil,nil]

  AI_IDS = [2,3,4,5,6]

  def available_spaces
    ((0..8).to_a - Move.where(game_id: id).pluck(:square))
  end

  def available_spaces_minmax(potential_board)
    i = -1
    spaces = potential_board.map do |space| 
      i += 1
      space == nil ? i : nil 
    end
    spaces.compact
  end

  def finished?
    !!(self.winner_id || self.is_draw)
  end

  def ai_playing?
    AI_IDS.include?(player1_id) || AI_IDS.include?(players_id)
  end

  def ai_symbol
    AI_IDS.include?(player1_id) ? player1_symbol : player2_symbol
  end

  def ai_move
    available_spaces.sample
  end

  def load_ai
    ai_id = self.whose_turn
    case ai_id 
    when 2
      @move = Move.create(player_id: 2 ,game_id: id,square: ai_move, value: ai_symbol)
    when 3
      maxmin(ai_symbol, board)
      @move = Move.create(player_id: 3 ,game_id: id,square: @best_choice, value: ai_symbol)
    when 4
      minmax(ai_symbol, board)
      @move = Move.create(player_id: 4 ,game_id: id,square: @best_choice, value: ai_symbol)
    when 5
      if [true, false].sample
        minmax(ai_symbol, board)
        @move = Move.create(player_id: 5 ,game_id: id,square: @best_choice, value: ai_symbol)
      else
        @move = Move.create(player_id: 5 ,game_id: id,square: ai_move, value: ai_symbol)
      end
    when 6
      if [true, false].sample
        minmax(ai_symbol, board)
        @move = Move.create(player_id: 6 ,game_id: id,square: @best_choice, value: ai_symbol)
      else
        maxmin(ai_symbol, board)
        @move = Move.create(player_id: 6 ,game_id: id,square: @best_choice, value: ai_symbol)
      end
    end

    self.moves << @move
  end

  def score(board)
    if winning_symbol(board) == ai_symbol
      return 10
    elsif winning_symbol(board) == switch(ai_symbol)
      return -10
    end
    0
  end

  def reverse_score(board)
    if winning_symbol(board) == ai_symbol
      return -10
    elsif winning_symbol(board) == switch(ai_symbol)
      return 10
    end
    0
  end

  def switch(symbol)
    symbol == 'x' ? 'o' : 'x'
  end

  def tie?(board)
    board.compact.size == 9
  end

  def game_over?(board)
    winning_symbol(board) || tie?(board)
  end

  def best_move(current_symbol, scores)
    if current_symbol == ai_symbol
      scores.max_by { |_k, v| v }
    else
      scores.min_by { |_k, v| v }
    end
  end

  def minmax(current_symbol, board)
    return score board if game_over? board
    scores = {}
  
    available_spaces_minmax(board).each do |space|
      potential_board ||= board.dup
      potential_board[space] = current_symbol
      scores[space] = minmax(switch(current_symbol),potential_board)

    end
    @best_choice, best_score = best_move current_symbol, scores
    best_score
  end

  def maxmin(current_symbol, board)
    return reverse_score board if game_over? board
    scores = {}
  
    available_spaces_minmax(board).each do |space|
      potential_board ||= board.dup
      potential_board[space] = current_symbol
      scores[space] = maxmin(switch(current_symbol),potential_board)

    end
    @best_choice, best_score = best_move current_symbol, scores
    best_score
  end

  def ai_turn?
    self.whose_turn == 2 || self.whose_turn == 3 || self.whose_turn == 4 || self.whose_turn == 5 || self.whose_turn == 6
  end

  def whose_turn
    return player1_id if moves.empty?
    moves.last.player_id == player1_id ? player2_id : player1_id
  end

  def lose_coin_toss?
    [true,false].sample
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

  def winning_game?
    !!WINNING_LINES.detect do |winning_line|
      (winning_line & moves.where(player_id: moves.last.player_id).pluck(:square)).size == 3
    end  
  end

  def drawn_game?
    board.all?
  end

  def winning_symbol(potential_board)
    return 'x' if WINNING_LINES.any? { |line| line.all? { |square| potential_board[square] == 'x' } }
    return 'o' if WINNING_LINES.any? { |line| line.all? { |square| potential_board[square] == 'o' } }
  end

end
