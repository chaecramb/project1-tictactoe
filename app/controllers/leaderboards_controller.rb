class LeaderboardsController < ApplicationController
  def index
    @users = User.all
  end

end