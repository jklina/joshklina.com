class TagsController < ApplicationController
  def show
    @tag = Tag.find_by_slug!(params[:id])
    @posts = @tag.posts.published.sorted_by_published_date
  end
end
