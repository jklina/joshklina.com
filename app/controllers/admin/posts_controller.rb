class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def edit
  end

  def update
  end
end
