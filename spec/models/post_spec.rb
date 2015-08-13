require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should have_many(:taggings) }
  it { should have_many(:tags).through(:taggings) }
  it { should belong_to(:author).class_name('User') }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
  it { should validate_length_of(:title).is_at_most(244) }
  it { should validate_presence_of(:body) }

  it_behaves_like "a sluggable"

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

  describe ".sorted_by_published_date" do
    it "finds all the published posts ordered by date with the tag" do
      tagged_older_post = create(:post, published: true)
      tagged_newer_post = create(:post, published: true)

      tagged_older_post.published_at = Date.today - 2.days
      tagged_newer_post.published_at = Date.today
      tagged_older_post.save!
      tagged_newer_post.save!

      expect(Post.sorted_by_published_date).
        to eq([tagged_newer_post, tagged_older_post])
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
