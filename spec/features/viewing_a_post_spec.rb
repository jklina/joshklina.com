require "rails_helper"

RSpec.feature "Viewing a post", :type => :feature do
  scenario "a visitor can view published posts" do
    post = create(:post, published: true)

    visit root_path
    click_link(post.title)

    expect(current_path).to eq(post_path(post))
    expect(page).to have_text(post.title)
    expect(page).to have_text(post.body)
  end

  scenario "a visitor cannot view unpublished posts" do
    post = create(:post, published: false)

    expect { visit post_path(post) }.
      to raise_error(ActiveRecord::RecordNotFound)
  end
end
