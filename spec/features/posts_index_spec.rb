require "rails_helper"

RSpec.feature "Posts index page", :type => :feature do
  scenario "a visitor can view published posts" do
    published_post = create(:post, published: true, title: 'Post1')
    unpublished_post = create(:post, published: false, title: 'Post2')

    visit root_path

    expect(page).to have_text('Post1')
    expect(page).to_not have_text('Post2')
  end

  scenario "a visitor received a notification when there are no posts" do
    visit root_path

    expect(page).to have_text(I18n.t("posts.index.no_posts_warning"))
  end
end
