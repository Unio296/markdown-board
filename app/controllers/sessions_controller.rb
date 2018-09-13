class SessionsController < ApplicationController
  
  #ユーザログイン時にSession作成
  def create
    user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    session[:user_id] = user.id                                       #cookiesをクライアントに保存
    flash[:success] = "ユーザー認証が完了しました。"
    redirect_back_or user_url(user.nickname)
    #redirect_to user_url(user.nickname)
  end

  #ユーザログアウト時にsession削除
  def destroy
    reset_session
    flash[:success] = "ログアウトしました。"
    redirect_to root_path
  end
end
