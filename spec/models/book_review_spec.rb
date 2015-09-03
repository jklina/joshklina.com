require 'rails_helper'

RSpec.describe BookReview, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:review) }
  it { should validate_presence_of(:author) }
  it { should validate_length_of(:title).is_at_most(244) }
  it { should validate_length_of(:author).is_at_most(244) }

  it_behaves_like "a sluggable"

  describe "#slug" do
    it "is created automatically from the title if not provided" do
      review = create(:book_review, title: "My Title")

      expect(review.slug).to eq('my-title')
    end

    it "is created user input if provided" do
      review = create(:book_review, title: "My Title", slug: "my slug")

      expect(review.slug).to eq('my-slug')
    end
  end
end
