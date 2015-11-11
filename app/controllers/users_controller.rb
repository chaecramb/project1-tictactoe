class UsersController < ApplicationController
  def index
    @users = User.all_except(current_user.id).search(params[:search])
  end

  def show
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:id, :search)
    end

end