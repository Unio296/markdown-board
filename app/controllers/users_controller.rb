class UsersController < ApplicationController
  #ユーザ削除(destroy)は本人のみ
  before_action :correct_user, only: :destroy
  
  def show
    @user = User.find_by(nickname: params[:nickname])
    @posts = @user.posts.all.order(created_at: "DESC")
  end

  def new
  end

  #def index 
  #  @users = User.all
  #end

  def destroy
    #correct_userで@user取得
    @user.destroy
    session[:user_id] = nil #sessionも削除

    flash[:success] = "ユーザを削除しました"
    redirect_to root_path
  end

  private

    #current_userが@userと一致するか
    def correct_user
      @user = User.find_by(nickname: params[:nickname])
      unless current_user?(@user) then
        flash[:danger] = "あなたは#{@user.nickname}ではありません"
        redirect_to user_path(@user.nickname)
      end
    end
end
