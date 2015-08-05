require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should have_many(:taggings) }
  it { should have_many(:posts).through(:taggings) }

  it { should validate_presence_of(:label) }
  it { should validate_length_of(:label).is_at_most(244) }
  it { should validate_uniqueness_of(:label).case_insensitive }
  it { should have_db_index(:label).unique(true) }

  describe "#to_s" do
    it "returns the label" do
      tag = build(:tag, label: 'coffee')

      expect(tag.to_s).to eq('coffee')
    end
  end
end
