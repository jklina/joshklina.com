require 'rails_helper'

RSpec.describe Admin::TagsController, type: :controller do
  before(:each) { build_user_and_login }

  describe "GET #index" do
    it "finds all the tags" do
      tag = create(:tag)

      get :index

      expect(assigns(:tags)).to eq([tag])
    end
  end

  describe "GET #new" do
    it "builds a new tag" do
      get :new

      expect(assigns(:tag)).to be_a_new(Tag)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new tag" do
        user = create(:user)
        valid_tag_attributes = attributes_for(:tag, label: 'Label')

        post :create, tag: valid_tag_attributes

        expect(assigns(:tag)).to be_persisted
        expect(assigns(:tag).label).to eq('Label')
        expect(flash[:success]).to eq('Tag successfully created.')
        expect(response).to redirect_to(admin_tags_path)
      end
    end

    context "with invalid attributes" do
      it "re-renders the new action" do
        invalid_tag_attributes = attributes_for(:tag, label: '')
        post :create, tag: invalid_tag_attributes

        expect(assigns(:tag)).to be_a_new(Tag)
        expect(assigns(:tag).label).to eq('')
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "finds the tag" do
      tag = create(:tag)

      get :edit, id: tag

      expect(assigns(:tag)).to eq(tag)
    end
  end

  describe "GET #update" do
    it "finds the tag" do
      tag = create(:tag)

      patch :update, id: tag, tag: {label: 'new label'}

      expect(assigns(:tag)).to eq(tag)
    end

    context "when the attributes are valid" do
      it "updates the tags attributes when given" do
        tag = create(:tag, label: 'old label')

        patch :update, id: tag, tag: {label: "new label"}
        tag.reload

        expect(tag.label).to eq("new label")
      end
    end

    context "when the attributes are invalid" do
      it "renders the edit page" do
        tag = create(:tag, label: 'old label')

        patch :update, id: tag, tag: {label: ""}

        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the specified tag" do
      tag = create(:tag)

      delete :destroy, id: tag

      expect(response).to redirect_to(admin_tags_path)
      expect(Tag.all).to eq([])
    end
  end
end
