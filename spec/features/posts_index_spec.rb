require "rails_helper"

RSpec.feature "Posts index page", :type => :feature do
  scenario "a visitor can view posts" do
    post = create(:post)

    visit root_path

    expect(page).to have_text(post.title)
  end

  scenario "a visitor received a notification when there are no posts" do
    visit root_path

    expect(page).to have_text(I18n.t("posts.index.no_posts_warning"))
  end
end
