require "rails_helper"

RSpec.feature "Book review management", :type => :feature do
  scenario "user can view book_reviews" do
    user = create_user_and_login
    book_review = create(:book_review,
                         published: true,
                         book_title: 'My Title is Good')

    visit admin_book_reviews_path

    expect(page).to have_text(book_review.body)
  end


  it do
    create_user_and_login
    paginates(model: BookReview,
              increment: 25,
              selector: '.book_review',
              model_attributes:{published: true}) do
      visit admin_book_reviews_path
    end
  end

  scenario "user can edit book reviews " do
    user = create_user_and_login(name: 'Andrew')
    author = create(:user, name: 'Josh')
    book_review = create(:book_review, book_title: 'My Title')
    tag = create(:tag, label: 'coffee')

    visit edit_admin_book_review_path(book_review)

    expect(find_field('Book title').value).to eq('My Title')
    expect(page).to have_text(book_review.body)

    fill_in "Book title", with: "Hello World!"
    fill_in "Body", with: "1, 2, 3, 4 get your booty on the floor."
    fill_in "Slug", with: "my slug"
    check "coffee"
    select "Josh", from: "book_review[author_id]"
    check "Published"
    click_on "Update Book review"

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
