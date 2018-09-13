module SessionsHelper

    # 渡されたユーザーがログイン済みユーザーであればtrueを返す
    def current_user?(user)
      user == current_user
    end

  # 記憶したURL (もしくはデフォルト値) にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLをCookiesに記憶
  def store_location
    if request.get? then
      session[:forwarding_url] = request.url      #getリクエストの場合は遷移後のurlを記憶
    else
      session[:forwarding_url] = request.referer  #それ以外のリクエストの場合は遷移前のurlを記憶
    end
  end
end
