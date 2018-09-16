class PostsController < ApplicationController
  #post投稿と削除と公開非公開切り替えは本人のみ
  before_action :logged_in_user, only: [:new, :create, :destroy, :published_false, :published_true]
  before_action :correct_user, only: [:new, :create, :destroy, :published_false, :published_true]

  def index
    @user = User.find_by(nickname: params[:user_nickname])
    @posts = @user.posts.all
  end

  def show
    @user = User.find_by(nickname: params[:user_nickname])
    @post = @user.posts.find_by(slug: params[:slug])
  end


  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to user_path(current_user.nickname)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by(nickname: params[:user_nickname])
    @post = @user.posts.find_by(slug: params[:slug])
    published_check(@post)
  end

  def update
    @user = User.find_by(nickname: params[:user_nickname])
    @post = @user.posts.find_by(slug: params[:slug])
    if @post.update_attributes(post_params)
      flash[:success] = "Post updated!"
      redirect_to user_post_path(@user.nickname,@post.slug)
    else
      render 'edit'
    end
  end

  def destroy
    @post = current_user.posts.find_by(slug: params[:slug])   #ログイン中のuserのpost検索
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to user_path(@post.user.nickname)
  end

  def published_true
    @user = User.find_by(nickname: params[:user_nickname])
    @post = @user.posts.find_by(slug: params[:slug])
    @post.published = true
    @post.save
    #debugger
    #Ajax用
    respond_to do |format|
      format.html { redirect_to user_path(@user.nickname) }
      format.js
    end
  end

  def published_false
    @user = User.find_by(nickname: params[:user_nickname])
    @post = @user.posts.find_by(slug: params[:slug])
    @post.published = false
    @post.save
    #Ajax用
    respond_to do |format|
      format.html { redirect_to user_path(@user.nickname) }
      format.js
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :content)
    end

    def correct_user
      @user = User.find_by(nickname: params[:user_nickname])
      unless current_user?(@user) then
        flash[:danger] = "あなたは#{@user.nickname}ではありません"
        redirect_to user_path(@user.nickname)
      end
      #@post = current_user.posts.find_by(slug: params[:slug])   #ログイン中のuserのpost検索
      #if @post.nil? then
      #  @user = User.find_by(nickname: params[:user_nickname])
      #  debugger
      #  flash[:danger] = "あなたは#{@user.nickname}ではありません"
      #  redirect_to user_path(@user.nickname)
      #end
    end

    #postが非公開の場合、本人以外編集させない
    def published_check(post)
      unless post.published
        unless current_user?(post.user)
          flash[:danger] = "この記事は非公開に設定されています"
          redirect_to user_path(post.user.nickname)
        end
      end
    end

end
