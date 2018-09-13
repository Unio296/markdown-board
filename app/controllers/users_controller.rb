class UsersController < ApplicationController
  def show
    @user = User.find_by(nickname: params[:nickname])
    @posts = @user.posts.all.order(created_at: "DESC")
  end

  def new
  end

  def index 
    @users = User.all
  end
end
