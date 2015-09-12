require 'rails_helper'

RSpec.describe Tag, type: :model do

  it { should have_many(:taggings) }

  it { should validate_presence_of(:label) }
  it { should validate_length_of(:label).is_at_most(244) }
  it { should validate_uniqueness_of(:label).case_insensitive }
  it { should have_db_index(:label).unique(true) }

  it_behaves_like "a sluggable"

  describe "#slug" do
    it "is created automatically from the label if not provided" do
      tag = create(:tag, label: "My Tag")

      expect(tag.slug).to eq('my-tag')
    end

    it "is created by user input if provided" do
      tag = create(:tag, label: "My Tag", slug: "my slug")

      expect(tag.slug).to eq('my-slug')
    end
  end

  describe "#to_s" do
    it "returns the label" do
      tag = build(:tag, label: 'coffee')

      expect(tag.to_s).to eq('coffee')
    end
  end

  describe "methods created for looking up tagged items by type" do
    it "dynamically makes methods for finding types of associated items to tag" do

      # Note using two taggable models here to test that it works with different models
      post = create(:post)
      book_review = create(:book_review)
      tag = create(:tag)
      post.tags << tag
      book_review.tags << tag
      post.save!
      book_review.save!

      expect(tag.posts).to eq([post])
      expect(tag.book_reviews).to eq([book_review])
    end

    it "accepts typical query arguments" do
      published_post = create(:post, published: true)
      unpublished_post = create(:post, published: false)
      tag = create(:tag)

      published_post.tags << tag
      unpublished_post.tags << tag

      expect(tag.posts.where(published: true)).to eq([published_post])
    end

    it "returns method missing error if there isn't a valid model" do
      tag = create(:tag)

      expect { tag.ipsums }.to raise_error(NoMethodError)
    end
  end
end
