class PostsController < ApplicationController
  #post投稿と削除は本人のみ
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user, only: [:new, :create, :destroy]

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
end
