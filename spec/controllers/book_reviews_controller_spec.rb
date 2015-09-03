require 'rails_helper'

RSpec.describe BookReviewsController, type: :controller do
  describe "GET #index" do
    it "finds all the book reviews ordered by publish date" do
      new_book_review = create(:book_review)
      old_book_review = create(:book_review)
      old_book_review.published_at = Date.today - 1.day
      old_book_review.save!

      get :index


      expect(assigns(:book_reviews)).to eq([new_book_review, old_book_review])
    end

    it "paginates the results in chunks of 10" do
      book_reviews = FactoryGirl.create_list(:book_review, 11, published: true)

      get :index

      expect(assigns(:book_reviews).count).to eq(10)
    end
  end
end
