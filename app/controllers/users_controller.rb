class UsersController < ApplicationController
  def index
    if current_user
      @users = User.all_except(current_user.id).search(params[:search])
    else
      @users = User.search(params[:search])
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:id, :search)
    end

end