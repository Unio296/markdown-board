class PostsController < ApplicationController

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
      redirect_to user_posts_path
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
  private
    def post_params
      params.require(:post).permit(:title, :content)
    end

end
