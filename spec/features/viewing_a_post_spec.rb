require "rails_helper"

RSpec.feature "Viewing a post", :type => :feature do
  scenario "a visitor can view posts" do
    post = create(:post)

    visit root_path
    click_link(post.title)

    expect(current_path).to eq(post_path(post))
    expect(page).to have_text(post.title)
    expect(page).to have_text(post.body)
  end
end
