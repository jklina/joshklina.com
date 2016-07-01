require 'rails_helper'

RSpec.describe Admin::BookReviewsController, type: :controller do
  before(:each) { build_user_and_login }

  describe "GET #index" do
    it "finds all the book_reviews" do

      book_review = create(:book_review)

      get :index

      expect(assigns(:book_reviews).last).to eq(book_review)
    end

    it { paginates(model: BookReview, increment: 25) { get :index } }
  end

  describe "GET #new" do
    it "builds a new post" do
      get :new

      expect(assigns(:book_review)).to be_a_new(BookReview)
    end

    it { finds_authors_for { get :new } }
    it { finds_tags_for { get :new } }
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new post" do
        user = create(:user)
        valid_book_review_attributes = attributes_for(:book_review,
                                              book_title: 'Title',
                                              book_author: 'Author',
                                              author_id: user.id,
                                              body: 'Review')

        post :create, params: { book_review: valid_book_review_attributes }

        expect(assigns(:book_review)).to be_persisted
        expect(assigns(:book_review).book_title).to eq('Title')
        expect(assigns(:book_review).body).to eq('Review')
        expect(flash[:success]).to eq('Review successfully created.')
        expect(response).to redirect_to(admin_book_reviews_path)
      end
    end

    context "with invalid attributes" do
      it "re-renders the new action" do
        post :create, params: { book_review: invalid_book_review_attributes }

        expect(assigns(:book_review)).to be_a_new(BookReview)
        expect(assigns(:book_review).book_title).to eq('')
        expect(assigns(:book_review).body).to eq('the body')
        expect(response).to render_template(:new)
      end
    end

    it do
      finds_authors_for do
        post :create, params: { book_review: invalid_book_review_attributes }
      end
    end
    it do
      finds_tags_for do
        post :create, params: { book_review: invalid_book_review_attributes }
      end
    end
  end

  describe "GET #edit" do
    it "finds the book review" do
      review = create(:book_review)

      get :edit, params: { id: review }

      expect(assigns(:book_review)).to eq(review)
    end

    it { finds_authors_for { get :edit, params: { id: create(:book_review) } } }
    it { finds_tags_for { get :edit, params: { id: create(:book_review) } } }
  end
  describe "GET #update" do
    it "finds the book_review" do
      book_review = create(:book_review)

      patch :update, params: { id: book_review, book_review: {title: 'hello'} }

      expect(assigns(:book_review)).to eq(book_review)
    end

    it "updates the book_reviews attributes when given" do
      user = create(:user)
      book_review = create(:book_review)

      patch :update, params: { id: book_review,
                              book_review: {book_title: "hello!",
                                            body: "1,2,3,4",
                                            author_id: user.id}
      }

      book_review.reload

      expect(book_review.book_title).to eq("hello!")
      expect(book_review.body).to eq("1,2,3,4")
      expect(book_review.author).to eq(user)
    end

    it do
      finds_tags_for do
        book_review = create(:book_review)
        patch :update, params: { id: book_review,
                                book_review: {book_title: 'hello'}
        }
      end
    end

    it do
      finds_authors_for do
        book_review = create(:book_review)
        patch :update, params: { id: book_review,
                                 book_review: {book_title: 'hello'} }
      end
    end
  end

  def invalid_book_review_attributes
    attributes_for(:book_review,
                    book_title: '',
                    book_author: '',
                    body: 'the body')

  end
end
