class ToolsController < ApplicationController
  def index
    @tools = Tool.sorted_by_published_date.
      page(params[:page]).
      per(10)
  end
end
