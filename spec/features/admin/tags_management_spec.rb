require "rails_helper"

RSpec.feature "Tag management", :type => :feature do
  scenario "user can view tags" do
    user = create_user_and_login
    tag = create(:tag)

    visit admin_tags_path

    expect(page).to have_text(tag.label)
  end

#   scenario "user can edit tags " do
#     user = create_user_and_login(name: 'Andrew')
#     author = create(:user, name: 'Josh')
#     tag = create(:tag)
#
#     visit edit_admin_tag_path(tag)
#
#     expect(page).to have_text(tag.title)
#     expect(page).to have_text(tag.body)
#
#     fill_in "Title", with: "Hello World!"
#     fill_in "Body", with: "1, 2, 3, 4 get your booty on the floor."
#     fill_in "Slug", with: "my slug"
#     select "Josh", from: "tag[author_id]"
#     check "Published"
#     click_on "Update Post"
#
#     expect(page).to have_text("Hello World!")
#     expect(page).to have_text("1, 2, 3, 4 get your booty on the floor.")
#     expect(page).to have_text("my-slug")
#     expect(page).to have_text("Josh")
#     expect(page).to have_css(".published")
#   end
#
#   scenario "user can create tags " do
#     user = create_user_and_login(name: 'Andrew')
#     author = create(:user, name: 'Josh')
#   end
end

