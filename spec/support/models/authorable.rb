module Models
  module Authorable
    RSpec.shared_examples "an authorable" do
      it { should belong_to(:author).class_name('Exposition::User') }
      it { should validate_presence_of(:author) }
    end
  end
end
