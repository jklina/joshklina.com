class Admin::TagsController < Admin::AdminController
  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end
  
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = "Tag successfully created."
      redirect_to admin_tags_path
    else
      render :new
    end
  end

  def edit
    find_tag
  end

  def update
    find_tag
    if @tag.update(tag_params)
      flash[:success] = "Tag was successfully updated."
      redirect_to admin_tags_path
    else
      render action: 'edit'
    end
  end

  def destroy
    find_tag
    if @tag.destroy
      redirect_to admin_tags_path,
        notice: 'Tag was successfully destroyed.'
    else
      redirect_to admin_tags_path
    end
  end

  private

  def find_tag
    @tag = Tag.find_by_slug!(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:id, :label)
  end
end
