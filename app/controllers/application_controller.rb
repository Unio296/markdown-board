class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?    #helperとしても使えるようにする
  include SessionsHelper

  #存在しないページへのルーティングのため
  unless Rails.env.development?
    rescue_from Exception,                        with: :_render_500
    rescue_from ActiveRecord::RecordNotFound,     with: :_render_404
    rescue_from ActionController::RoutingError,   with: :_render_404
  end
  
  def routing_error
    raise ActionController::RoutingError, params[:path]
  end
  
    private
  
    def _render_404(e = nil)
      logger.info "Rendering 404 with exception: #{e.message}" if e
  
      if request.format.to_sym == :json
        render json: { error: '404 error' }, status: :not_found
      else
        render 'errors/404', status: :not_found
      end
    end
  
    def _render_500(e = nil)
      logger.error "Rendering 500 with exception: #{e.message}" if e
      Airbrake.notify(e) if e # Airbrake/Errbitを使う場合はこちら
  
      if request.format.to_sym == :json
        render json: { error: '500 error' }, status: :internal_server_error
      else
        render 'errors/500', status: :internal_server_error
      end
    end



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
