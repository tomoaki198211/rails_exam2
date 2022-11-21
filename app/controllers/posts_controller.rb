class PostsController < ApplicationController

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def new
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
    if @post.user == current_user
      render :edit
    else
      redirect_to posts_path,  notice:"編集出来ません。作成者のみ編集可能です"
    end
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
    set_post
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path, notice:"削除しました"
    else
      redirect_to posts_path, notice:"削除出来ません。作成者のみ削除可能です"
    end
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
    params.require(:post).permit(:content, :picture, :picture_cache)
  end

end
