require "rails_helper"

RSpec.feature "Home page", :type => :feature do
  scenario "user can view posts" do
    post = create(:post)

    visit root_path

    expect(page).to have_text(post.title)
  end
end
