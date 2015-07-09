require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET #index" do
    it "finds all the posts that are published ordered by publish date" do
      new_blog_post = create(:post, published: true)
      old_blog_post = create(:post, published: true)
      unpublished_blog_post = create(:post, published: false)
      old_blog_post.published_at = Date.today - 1.day
      old_blog_post.save!

      get :index

      expect(assigns(:posts)).to eq([new_blog_post, old_blog_post])
    end
  end

  describe "GET #show" do
    it "finds the published post based off the given id" do
      blog_post = create(:post, published: true)

      get :show, id: blog_post

      expect(assigns(:post)).to eq(blog_post)
    end

    it "cannot find an unpublished post" do
      blog_post = create(:post, published: false)

      expect { get :show, id: blog_post }.
        to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
