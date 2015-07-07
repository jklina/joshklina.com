require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    it "finds all the posts" do
      blog_post = create(:post)

      get :index

      expect(assigns(:posts)).to eq([blog_post])
    end
  end
end
