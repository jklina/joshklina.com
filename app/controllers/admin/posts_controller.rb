class Admin::PostsController < Admin::AdminController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post successfully created."
      redirect_to admin_posts_path
    else
      render :new
    end
  end

  def edit
    find_post
  end

  def update
    find_post
    if @post.update(post_params)
      flash[:success] = "Post was successfully updated."
      redirect_to admin_posts_path
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
