class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new
      if user.role? :admin
        can :manage, :all
      elsif user.role? :player
        can :create, :all
        can [:read, :update], Game do |game|
          (user.id == game.player1_id) || (user.id == game.player2_id) || (game.player1_id == 1)
          end
      else
        can :read, :all
      end      
  end
  
end
