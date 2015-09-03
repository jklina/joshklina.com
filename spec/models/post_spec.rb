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
  it_behaves_like "a publishable"

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


  describe "#to_param" do
    it "returns the slug" do
      post = build(:post, slug: 'my-slug')

      expect(post.to_param).to eq('my-slug')
    end
  end
end
