require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  describe "#published" do
    it "is false by default" do
      post = build(:post)

      expect(post.published?).to be_falsey
    end
  end

  describe "#published_at" do
    it "is null by default" do
      post = build(:post)

      expect(post.published_at).to be_nil
    end

    it "is set to the current date when the post is published" do
      post = create(:post)

      post.published = true
      post.save!

      expect(post.published_at).to eq(Date.today)
    end

    it "only updates when the published attribute changes" do
      post = create(:post, published: true)

      post.published_at = Date.today - 1.day
      post.save!

      post.published = true
      post.save!

      expect(post.published_at).to eq(Date.today - 1.day)
    end
  end
end
