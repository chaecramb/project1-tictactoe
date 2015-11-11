class LeaderboardsController < ApplicationController
  def index
    @users = User.order('points DESC').all
  end

end