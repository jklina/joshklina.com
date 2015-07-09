class PostsController < ApplicationController
  def index
    @posts = Post.published.order(published_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end
end
