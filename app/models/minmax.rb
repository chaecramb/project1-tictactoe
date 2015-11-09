module Tictac
  class Board
    attr_reader :spaces

    # [0][1][2]
    # [3][4][5]
    # [6][7][8]

    WINNING_COMBINATIONS = [
      # Horizontal wins:
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      # Vertical wins:
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      # Diagonal wins:
      [0, 4, 8], [2, 4, 6]
    ]

    def initialize
      @spaces = Array.new(9)
    end

    def moves
      spaces.compact.count
    end

    def place_piece(space, piece)
      spaces[space] = piece
    end

    def valid_move?(space)
      (0..8).include?(space) && space_available?(space)
    end

    def space_available?(space)
      spaces[space].nil?
    end

    def available_spaces
      available = []
      spaces.each_index do |i|
        available << i if space_available?(i)
      end
      available
    end

    def winning_combination
      WINNING_COMBINATIONS.each do |combo|
        if spaces[combo[0]] == spaces[combo[1]] && spaces[combo[1]] == spaces[combo[2]]
          return combo unless spaces[combo[0]].nil?
        end
      end
      false
    end

    def winner
      combo = winning_combination
      combo ? spaces[combo[0]] : false
    end

    def tie?
      available_spaces.empty?
    end

    private

    def initialize_dup(other)
      super(other)
      @spaces = other.spaces.dup
    end
  end
end

module Tictac
  class Player
    attr_reader :piece, :ui

    def initialize(piece, ui)
      @piece, @ui = piece, ui
    end

    def move(board)
      raise 'Not Implemented'
    end

    def to_s
      piece
    end
  end
end

require 'tictac/player'
require 'tictac/board'

module Tictac
  module Players
    class MinMax < Tictac::Player
      attr_reader :best_choice

      def initialize(piece, ui)
        super(piece, ui)
        @opponent = switch(piece)
      end

      def move(board)
        ui.thinking(piece)
        minmax(board, piece)
        board.place_piece(best_choice, piece)
      end

      def minmax(board, current_player)
        # If someone won, we are done with this 'game state' and must return to the caller
        # or previous stack frame
        return score board if game_over? board

        # Local collection of scores for this 'game state'
        scores = {}

        # For each available space on the board, loop through and apply min-max recursively
        board.available_spaces.each do |space|

          # Copy board so we don't mess up original (IMPORTANT)
          potential_board = board.dup

          # Move the current player to the space on the duplicate board
          potential_board.place_piece space, current_player

          # Recurse until the game is over
          # Switch players each time to mimic the rules of Tic-Tac-Toe
          scores[space] = minmax(potential_board, switch(current_player))
        end
        # We are only ever out of the previous loop once we have determined a path
        # to an 'end game' state

        # Now we can make the best choice for the current_player
        # (the moves that result in a win for our AI)
        @best_choice, best_score = best_move current_player, scores

        best_score
      end

      def game_over?(board)
        board.winner || board.tie?
      end

      def best_move(piece, scores)
        if piece == @piece
          scores.max_by { |_k, v| v }
        else
          scores.min_by { |_k, v| v }
        end
      end

      def score(board)
        if board.winner == piece
          return 10
        elsif board.winner == @opponent
          return -10
        end
        0
      end

      def switch(piece)
        piece == 'X' ? 'O' : 'X'
      end
    end
  end
end