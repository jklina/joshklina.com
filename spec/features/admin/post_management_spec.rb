require "rails_helper"

RSpec.feature "Post management", :type => :feature do
  scenario "user can view posts" do
    post = create(:post)

    visit admin_posts_path

    expect(page).to have_text(post.title)
  end

  scenario "user can edit posts " do
    post = create(:post)

    visit edit_admin_post_path(post)

    expect(page).to have_text(post.title)
    expect(page).to have_text(post.body)

    fill_in "Title", with: "Hello World!"
    fill_in "Body", with: "1, 2, 3, 4 get your booty on the floor."
    click_on "Update Post"

    expect(page).to have_text("Hello World!")
    expect(page).to have_text("1, 2, 3, 4 get your booty on the floor.")
  end

  scenario "user can create posts " do
    visit new_admin_post_path

    fill_in "Title", with: "Hello World!"
    fill_in "Body", with: "1, 2, 3, 4 get your booty on the floor."
    click_on "Create Post"

    expect(page).to have_text("Hello World!")
    expect(page).to have_text("1, 2, 3, 4 get your booty on the floor.")
    expect(page).to have_text("Post successfully created.")
  end

  scenario "user can fix invalid posts" do
    visit new_admin_post_path

    fill_in "Title", with: ""
    fill_in "Body", with: "1, 2, 3, 4 get your booty on the floor."
    click_on "Create Post"

    expect(page).to have_text("Title can't be blank")
    expect(page).to have_text("1, 2, 3, 4 get your booty on the floor.")
  end
end
