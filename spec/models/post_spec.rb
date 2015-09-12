require 'rails_helper'

RSpec.describe Post, type: :model do

  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(244) }
  it { should validate_presence_of(:body) }

  it_behaves_like "an authorable"
  it_behaves_like "a publishable"
  it_behaves_like "a sluggable"
  it_behaves_like "a taggable"

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
end
