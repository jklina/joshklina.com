class PostsController < ApplicationController
  def index
    @posts = Post.published.order(published_at: :desc)
  end

  def show
    @post = Post.published.find_by_slug!(params[:id])
  end
end
