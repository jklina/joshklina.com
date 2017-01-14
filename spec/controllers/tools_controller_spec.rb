require 'rails_helper'

RSpec.describe ToolsController, type: :controller do
  describe "GET #index" do
    it "finds all the tools ordered by publish date" do
      new_tool = create(:tool)
      old_tool = create(:tool)
      old_tool.published_at = Date.today - 1.day
      old_tool.save!

      get :index

      expect(assigns(:tools)).to eq([new_tool, old_tool])
    end

    it "paginates the results in chunks of 10" do
      tools = FactoryGirl.create_list(:tool, 11, published: true)

      get :index

      expect(assigns(:tools).count).to eq(10)
    end
  end
end
