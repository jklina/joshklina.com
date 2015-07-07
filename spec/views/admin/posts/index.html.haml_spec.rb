require 'rails_helper'

RSpec.describe "admin/posts/index.html.haml", type: :view do
  it "truncates the post body" do
    post_body = "This is a very very very very very very very very very very very very very very very very very very very very very very very very very long sentence."
    blog_post = create(:post, body: post_body)
    assign(:posts, [blog_post])

    render

    expect(rendered).to include("This is a very very very very very...")
  end
end
