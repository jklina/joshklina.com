require 'rails_helper'

RSpec.describe Admin::PostsController, type: :controller do

  describe "GET #index" do
    it "finds all the posts" do
      blog_post = create(:post)

      get :index

      expect(assigns(:posts).last).to eq(blog_post)
    end
  end

  describe "GET #edit" do
    it { finds_the_post }
  end

  describe "GET #update" do
    it { finds_the_post }

    it "updates the posts attributes when given" do
      blog_post = create(:post)

      patch :update, id: blog_post, post: {title: "hello!",
                                           body: "1,2,3,4"}

      blog_post.reload

      expect(blog_post.title).to eq("hello!")
      expect(blog_post.body).to eq("1,2,3,4")
    end
  end

  def finds_the_post
    blog_post = create(:post)

    get :edit, id: blog_post

    expect(assigns(:post)).to eq(blog_post)
  end
end
