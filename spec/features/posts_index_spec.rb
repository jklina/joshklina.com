require "rails_helper"

RSpec.feature "Posts index page", :type => :feature do
  scenario "a visitor can view published posts" do
    published_post = create(:post, published: true)
    unpublished_post = create(:post, published: false)

    visit root_path

    expect(page).to have_text(published_post.title)
    expect(page).to_not have_text(unpublished_post.title)
  end

  scenario "a visitor received a notification when there are no posts" do
    visit root_path

    expect(page).to have_text(I18n.t("posts.index.no_posts_warning"))
  end
end
