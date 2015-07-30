require 'rails_helper'

RSpec.describe Admin::TagsController, type: :controller do
  describe "GET #index" do
    it "finds all the tags" do
      tag = create(:tag)

      get :index

      expect(assigns(:tags)).to eq([tag])
    end
  end
end
