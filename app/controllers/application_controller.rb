class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?    #helperとしても使えるようにする
  include SessionsHelper
  
    private

    #ログイン中のユーザを返す
    def current_user
      return unless session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end

    #ログイン確認
    def logged_in?
      !!session[:user_id]
    end

    #ログイン中のユーザか？
    def correct_user?(user)
      return user == current_user
    end

    #認証
    def authenticate
      return if logged_in?
      redirect_to root_path, alert: "ログインしてください"
    end

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to root_url
      end
    end

end
