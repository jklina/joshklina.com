class TagsController < ApplicationController
  def show
    @tag = Tag.find_by_slug!(params[:id])
    @taggables = @tag.
      send(fetch_taggable_type).
      published.
      sorted_by_published_date.
      page(params[:page]).
      per(10)
  end

  private

  def fetch_taggable_type
    if params[:type]
      taggable_type = params[:type]
      return taggable_type.underscore.to_sym
    else
      return :posts
    end
  end
end
