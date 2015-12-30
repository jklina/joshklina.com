require "rails_helper"

RSpec.feature "Post management", :type => :feature do
  scenario "user can view posts" do
    user = create_user_and_login
    post = create(:post)

    visit admin_posts_path

    expect(page).to have_text(post.title)
  end

  it do
    create_user_and_login
    paginates(factory: :post, increment: 25, selector: '.post') do
      visit admin_posts_path
    end
  end

  scenario "user can paginate through the posts" do
    create_user_and_login
    posts = FactoryGirl.create_list(:post, 26)

    visit admin_posts_path
    expect(page).to have_selector('.post', count: 25)
    click_on('Next')

    expect(page).to have_selector('.post', count: 1)
  end

  scenario "user can edit posts " do
    user = create_user_and_login(name: 'Andrew')
    author = create(:user, name: 'Josh')
    post = create(:post)
    tag = create(:tag, label: 'coffee')

    visit edit_admin_post_path(post)

    expect(page).to have_text(post.title)
    expect(page).to have_text(post.body)

    fill_in "Title", with: "Hello World!"
    fill_in "Body", with: "1, 2, 3, 4 get your booty on the floor."
    fill_in "Slug", with: "my slug"
    check "coffee"
    select "Josh", from: "post[author_id]"
    check "Published"
    click_on "Update Post"

    expect(page).to have_text("Hello World!")
    expect(page).to have_text("1, 2, 3, 4 get your booty on the floor.")
    expect(page).to have_text("my-slug")
    expect(page).to have_text("Josh")
    expect(page).to have_text("Josh")
    expect(page).to have_text("coffee")
    expect(page).to have_css(".published")
  end

  scenario "user can create posts " do
    user = create_user_and_login(name: 'Andrew')
    author = create(:user, name: 'Josh')
    tag = create(:tag, label: 'coffee')

    visit new_admin_post_path
    fill_in "Title", with: "Hello World!"
    fill_in "Body", with: "1, 2, 3, 4 get your booty on the floor."
    fill_in "Slug", with: "my slug"
    select "Josh", from: "post[author_id]"
    check "coffee"
    check "Published"
    click_on "Create Post"

    expect(page).to have_text("Hello World!")
    expect(page).to have_text("1, 2, 3, 4 get your booty on the floor.")
    expect(page).to have_text("my-slug")
    expect(page).to have_css(".published")
    expect(page).to have_text("Josh")
    expect(page).to have_text("coffee")
    expect(page).to have_text("Post successfully created.")
  end

  scenario "user can fix invalid posts" do
    user = create_user_and_login
    visit new_admin_post_path

    fill_in "Title", with: ""
    fill_in "Body", with: "1, 2, 3, 4 get your booty on the floor."
    click_on "Create Post"

    expect(page).to have_text("Title can't be blank")
    expect(page).to have_text("1, 2, 3, 4 get your booty on the floor.")
  end
end
