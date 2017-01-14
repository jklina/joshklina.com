require 'rails_helper'

RSpec.describe Tool, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_length_of(:title).is_at_most(244) }

  it_behaves_like "a publishable"
  it_behaves_like "a sluggable"
  it_behaves_like "a taggable"

  describe "#slug" do
    it "is created automatically from the title if not provided" do
      tool = create(:tool, title: "My Title")

      expect(tool.slug).to eq('my-title')
    end

    it "is created user input if provided" do
      tool = create(:tool, title: "My Title", slug: "my slug")

      expect(tool.slug).to eq('my-slug')
    end
  end
end
