module Models
  module Taggable
    RSpec.shared_examples "a taggable" do
      it { should have_many(:tags).through(:taggings) }
      it { should have_many(:taggings) }
    end
  end
end

