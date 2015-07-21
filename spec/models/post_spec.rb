require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:author).class_name('User') }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
  it { should validate_length_of(:title).is_at_most(244) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:slug) }
  it { should validate_uniqueness_of(:slug).case_insensitive }
  it { should have_db_index(:slug).unique(true) }
  it { should validate_length_of(:slug).is_at_most(244) }

  describe "#slug" do
    it "is created automatically from the title if not provided" do
      post = create(:post, title: "My Title")

      expect(post.slug).to eq('my-title')
    end

    it "is created user input if provided" do
      post = create(:post, title: "My Title", slug: "my slug")

      expect(post.slug).to eq('my-slug')
    end
  end

  describe "#css_classes" do
    it "returns 'not-published' if the article is not published" do
      post = build(:post, published: false)

      expect(post.css_classes).to eq("not-published")
    end

    it "returns 'published' if the article is published" do
      post = build(:post, published: true)

      expect(post.css_classes).to eq("published")
    end
  end

  describe "#published" do
    it "is false by default" do
      post = build(:post)

      expect(post.published?).to be_falsey
    end
  end

  describe ".published" do
    it "returns only published posts" do
      published_post = create(:post, published: true)
      unpublished_post = create(:post, published: false)

      expect(Post.published).to eq([published_post])
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

  describe "#to_param" do
    it "returns the slug" do
      post = build(:post, slug: 'my-slug')

      expect(post.to_param).to eq('my-slug')
    end
  end
end
