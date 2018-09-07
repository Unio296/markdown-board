class UsersController < ApplicationController
  def show
    @user = User.find_by(nickname: params[:nickname])
  end

  def new
  end

  def index 
    @users = User.all
  end
end
