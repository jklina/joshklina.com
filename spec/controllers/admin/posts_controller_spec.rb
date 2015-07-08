require 'rails_helper'

RSpec.describe Admin::PostsController, type: :controller do

  describe "GET #index" do
    it "finds all the posts" do
      blog_post = create(:post)

      get :index

      expect(assigns(:posts).last).to eq(blog_post)
    end
  end

  describe "GET #new" do
    it "builds a new post" do
      get :new

      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new post" do
        valid_post_attributes = attributes_for(:post,
                                              title: 'Title',
                                              body: 'Body')

        post :create, post: valid_post_attributes

        expect(assigns(:post)).to be_persisted
        expect(assigns(:post).title).to eq('Title')
        expect(assigns(:post).body).to eq('Body')
        expect(flash[:success]).to eq('Post successfully created.')
        expect(response).to redirect_to(admin_posts_path)
      end
    end

    context "with invalid attributes" do
      it "re-renders the new action" do
        invalid_post_attributes = attributes_for(:post,
                                              title: '',
                                              body: 'Body')
        post :create, post: invalid_post_attributes

        expect(assigns(:post)).to be_a_new(Post)
        expect(assigns(:post).title).to eq('')
        expect(assigns(:post).body).to eq('Body')
        expect(response).to render_template(:new)
      end
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
