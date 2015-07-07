class Admin::PostsController < Admin::AdminController
  def index
    @posts = Post.all
  end

  def edit
    find_post
  end

  def update
    find_post
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: 'Post was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:id, :title, :body)
  end
end
