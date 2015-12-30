require 'rails_helper'

RSpec.describe Categorical::Tag, type: :model do
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

  describe "#to_param" do
    it "returns the slug" do
      tag = build(:tag, slug: 'my-slug')

      expect(tag.to_param).to eq('my-slug')
    end
  end

  describe "#to_s" do
    it "returns the label" do
      tag = build(:tag, label: 'coffee')

      expect(tag.to_s).to eq('coffee')
    end
  end
end
