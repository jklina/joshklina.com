require 'rails_helper'

RSpec.describe Admin::ToolsController, type: :controller do
  before(:each) { build_user_and_login }

  describe "GET #index" do
    it "finds all the tools" do

      tool = create(:tool)

      get :index

      expect(assigns(:tools).last).to eq(tool)
    end

    it { paginates(model: Tool, increment: 25) { get :index } }
  end

  describe "GET #new" do
    it "builds a new post" do
      get :new

      expect(assigns(:tool)).to be_a_new(Tool)
    end

    it { finds_tags_for { get :new } }
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new post" do
        user = create(:user)
        valid_tool_attributes = attributes_for(:tool,
                                              title: 'Title',
                                              body: 'Tool')

        post :create, params: { tool: valid_tool_attributes }

        expect(assigns(:tool)).to be_persisted
        expect(assigns(:tool).title).to eq('Title')
        expect(assigns(:tool).body).to eq('Tool')
        expect(flash[:success]).to eq('Tool successfully created.')
        expect(response).to redirect_to(admin_tools_path)
      end
    end

    context "with invalid attributes" do
      it "re-renders the new action" do
        post :create, params: { tool: invalid_tool_attributes }

        expect(assigns(:tool)).to be_a_new(Tool)
        expect(assigns(:tool).title).to eq('')
        expect(assigns(:tool).body).to eq('the body')
        expect(response).to render_template(:new)
      end
    end

    it do
      finds_tags_for do
        post :create, params: { tool: invalid_tool_attributes }
      end
    end
  end

  describe "GET #edit" do
    it "finds the tool" do
      review = create(:tool)

      get :edit, params: { id: review }

      expect(assigns(:tool)).to eq(review)
    end

    it { finds_tags_for { get :edit, params: { id: create(:tool) } } }
  end
  describe "GET #update" do
    it "finds the tool" do
      tool = create(:tool)

      patch :update, params: { id: tool, tool: {title: 'hello'} }

      expect(assigns(:tool)).to eq(tool)
    end

    it "updates the tools attributes when given" do
      user = create(:user)
      tool = create(:tool)

      patch :update, params: { id: tool,
                              tool: {title: "hello!",
                                            body: "1,2,3,4",
      }
      }

      tool.reload

      expect(tool.title).to eq("hello!")
      expect(tool.body).to eq("1,2,3,4")
    end

    it do
      finds_tags_for do
        tool = create(:tool)
        patch :update, params: { id: tool,
                                tool: {title: 'hello'}
        }
      end
    end
  end

  def invalid_tool_attributes
    attributes_for(:tool,
                    title: '',
                    body: 'the body')

  end
end
