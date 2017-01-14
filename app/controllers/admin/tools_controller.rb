class Admin::ToolsController < Exposition::Admin::AdminController
  def index
    @tools = Tool.sorted_by_published_date.
      page(params[:page]).
      per(25)
  end

  def new
    @tool = Tool.new
    find_tags
  end

  def create
    @tool = Tool.new(tool_params)
    if @tool.save
      flash[:success] = "Tool successfully created."
      redirect_to admin_tools_path

    else
      find_tags
      render :new
    end
  end

  def edit
    find_tool
    find_tags
  end

  def update
    find_tool
    find_tags
    if @tool.update(tool_params)
      flash[:success] = "Tool was successfully updated."
      redirect_to admin_tools_path
    else
      render action: 'edit'
    end
  end

  private

  def find_tool
    @tool = Tool.find_by_slug!(params[:id])
  end

  def find_tags
    @tags = Categorical::Tag.all
  end

  def tool_params
    params.require(:tool).permit(:id, :title, :body, :slug, :published, :url, tag_ids: [])
  end
end
