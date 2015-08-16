require 'rails_helper'

RSpec.describe Admin::PostsController, type: :controller do

  before(:each) { build_user_and_login }

  describe "GET #index" do
    it "finds all the posts" do
      blog_post = create(:post)

      get :index

      expect(assigns(:posts).last).to eq(blog_post)
    end

    it { paginates(model: Post, increment: 25) { get :index } }
  end

  describe "GET #new" do
    it "builds a new post" do
      get :new

      expect(assigns(:post)).to be_a_new(Post)
    end

    it "finds all the users and sets them as authors" do
      author = create(:user)
      get :new

      expect(assigns(:authors)).to eq([author])
    end

    it { finds_tags_for { get :new } }
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new post" do
        user = create(:user)
        valid_post_attributes = attributes_for(:post,
                                              title: 'Title',
                                              body: 'Body',
                                              author_id: user.id)

        post :create, post: valid_post_attributes

        expect(assigns(:post)).to be_persisted
        expect(assigns(:post).title).to eq('Title')
        expect(assigns(:post).body).to eq('Body')
        expect(assigns(:post).author).to eq(user)
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

    it "finds all the users and sets them as authors" do
      author = create(:user)
      post_attributes = attributes_for(:post)

      post :create, post: post_attributes

      expect(assigns(:authors)).to eq([author])
    end

    it { finds_tags_for { post :create, post: attributes_for(:post) } }
  end

  describe "GET #edit" do
    it "finds the post" do
      blog_post = create(:post)

      get :edit, id: blog_post

      expect(assigns(:post)).to eq(blog_post)
    end

    it "finds all the users and sets them as authors" do
      author = create(:user)
      post = create(:post, author: author)

      get :edit, id: post

      expect(assigns(:authors)).to eq([author])
    end

    it { finds_tags_for { get :edit, id: create(:post) } }
  end

  describe "GET #update" do
    it "finds the post" do
      blog_post = create(:post)

      patch :update, id: blog_post, post: {title: 'hello'}

      expect(assigns(:post)).to eq(blog_post)
    end

    it "finds all the users and sets them as authors" do
      author = create(:user)
      post = create(:post, author: author)

      patch :update, id: post, post: {title: 'hello'}

      expect(assigns(:authors)).to eq([author])
    end

    it "updates the posts attributes when given" do
      user = create(:user)
      blog_post = create(:post)

      patch :update, id: blog_post, post: {title: "hello!",
                                           body: "1,2,3,4",
                                           author_id: user.id}

      blog_post.reload

      expect(blog_post.title).to eq("hello!")
      expect(blog_post.body).to eq("1,2,3,4")
      expect(blog_post.author).to eq(user)
    end

    it do
      finds_tags_for do
        blog_post = create(:post)
        patch :update, id: blog_post, post: {title: 'hello'}
      end
    end
  end

  def finds_tags_for
    tag = create(:tag)
    post_attributes = attributes_for(:post)

    yield

    expect(assigns(:tags)).to eq([tag])
  end
end
