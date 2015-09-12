require 'rails_helper'

RSpec.describe BookReview, type: :model do
  it { should validate_presence_of(:book_title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:book_author) }
  it { should validate_length_of(:book_title).is_at_most(244) }
  it { should validate_length_of(:book_author).is_at_most(244) }

  it_behaves_like "an authorable"
  it_behaves_like "a publishable"
  it_behaves_like "a sluggable"
  it_behaves_like "a taggable"

  describe "#slug" do
    it "is created automatically from the title if not provided" do
      review = create(:book_review, book_title: "My Title")

      expect(review.slug).to eq('my-title')
    end

    it "is created user input if provided" do
      review = create(:book_review, book_title: "My Title", slug: "my slug")

      expect(review.slug).to eq('my-slug')
    end
  end
end
