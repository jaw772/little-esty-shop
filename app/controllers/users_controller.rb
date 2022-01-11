class UsersController < ApplicationController
  def index
  end
  def new
    @user = User.create()
  end
  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    redirect_to '/', notice: "Welcome #{user.username}!"
  end

  def show
    @user = User.find(session[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
