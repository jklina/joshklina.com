module Models
  module Sluggable
    RSpec.shared_examples "a sluggable" do
      it { should validate_presence_of(:slug) }
      it { should validate_uniqueness_of(:slug).case_insensitive }
      it { should have_db_index(:slug).unique(true) }
      it { should validate_length_of(:slug).is_at_most(244) }

      describe "#to_param" do
        it "returns the slug" do
          sluggable = build(described_class.name.underscore, slug: 'my-slug')

          expect(sluggable.to_param).to eq('my-slug')
        end
      end
    end
  end
end

