class Admin::PostsController < Admin::AdminController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    find_authors
    find_tags
  end

  def create
    @post = Post.new(post_params)
    find_authors
    find_tags
    if @post.save
      flash[:success] = "Post successfully created."
      redirect_to admin_posts_path
    else
      render :new
    end
  end

  def edit
    find_post
    find_authors
    find_tags
  end

  def update
    find_post
    find_authors
    find_tags
    if @post.update(post_params)
      flash[:success] = "Post was successfully updated."
      redirect_to admin_posts_path
    else
      render action: 'edit'
    end
  end

  private

  def find_authors
    @authors = User.all
  end

  def find_post
    @post = Post.find_by_slug!(params[:id])
  end

  def find_tags
    @tags = Tag.all
  end

  def post_params
    params.require(:post).permit(:id, :title, :body, :slug, :published, :author_id, tag_ids: [])
  end
end
