require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TagHelper. For example:
#
# describe TagHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TagHelper, type: :helper do
  describe '#display_tags_for' do
    it 'finds the correct tags from the taggable and lists them' do
      tag = create(:tag, label: 'My Tag')
      tag2 = create(:tag, label: 'My Tag 2')
      taggable = create(:post)

      taggable.tags << tag
      taggable.tags << tag2
      taggable.save!

      expected_result = "<div class=\"tags\"><span class=\"tags\"><a href=\"/tags/my-tag-2?type=post\">My Tag 2</a></span><span class=\"tags\"><a href=\"/tags/my-tag?type=post\">My Tag</a></span></div>"
      expect(helper.display_tags_for(taggable)).to eq(expected_result)
    end
  end
end
