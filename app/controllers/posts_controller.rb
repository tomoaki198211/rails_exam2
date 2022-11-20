class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    login_required
    @post = Post.new
  end

  def show
    set_post
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = @current_user.id
    return render :new if params[:back]
    if @post.save
      redirect_to posts_path, notice:"作成しました！"
    else
      render :new
    end
  end

  def edit
    set_post
  end

  def update
    set_post
      if @post.update(post_params)
        redirect_to posts_path, notice:"編集しました"
      else
        render :edit
      end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice:"削除しました"
  end

  def confirm
    @post = Post.new(post_params)
    render :new if @post.invalid?
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end

end
