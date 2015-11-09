class Move < ActiveRecord::Base
  belongs_to :game

  validates :value, inclusion: { in: %w(o x) }

  validate :on_board, on: :create
  validate :empty_square, on: :create
  validate :own_turn, on: :create

  def on_board
    errors.add(:square, "square is not on board") unless (0..8).include? self.square
  end

  def empty_square
    errors.add(:square, "square is already taken") if Move.where(game_id: self.game_id).pluck(:square).include? self.square
  end

  def own_turn
    errors.add(:player_id, "it is not your turn") unless self.player_id == Game.find(self.game_id).whose_turn
  end

end
