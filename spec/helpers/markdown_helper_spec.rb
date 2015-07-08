require 'rails_helper'

RSpec.describe MarkdownHelper, type: :helper do
  describe "#markdown_to_html" do
    it "converts markdown into html" do
      expect(helper.markdown_to_html("this *is* really great")).
        to eq("<p>this <em>is</em> really great</p>\n")
    end
  end
end
