require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET #index" do
    it "finds all the posts" do
      blog_post = create(:post)

      get :index

      expect(assigns(:posts)).to eq([blog_post])
    end
  end

  describe "GET #show" do
    it "finds the post based off the given id" do
      blog_post = create(:post)

      get :show, id: blog_post

      expect(assigns(:post)).to eq(blog_post)
    end
  end
end
