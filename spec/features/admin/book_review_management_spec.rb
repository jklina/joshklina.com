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
    paginates(factory: :book_review,
              increment: 25,
              selector: '.book_review',
              attributes:{published: true}) do
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

    fill_in_book_review_form
    click_on "Update Book review"

    confirm_book_review_fields
  end

  scenario "user can create book reviews " do
    user = create_user_and_login(name: 'Andrew')
    author = create(:user, name: 'Josh')
    tag = create(:tag, label: 'coffee')

    visit new_admin_book_review_path
    fill_in_book_review_form
    click_on "Create Book review"

    confirm_book_review_fields
    expect(page).to have_text("Review successfully created.")
  end

  scenario "user can fix invalid book reviews" do
    user = create_user_and_login
    visit new_admin_book_review_path

    fill_in "Book title", with: ""
    fill_in "Body", with: "1, 2, 3, 4 get your booty on the floor."
    click_on "Create Book review"

    expect(page).to have_text("Book title can't be blank")
    expect(page).to have_text("1, 2, 3, 4 get your booty on the floor.")
  end

  def fill_in_book_review_form
    fill_in "Book title", with: "Hello World!"
    fill_in "Book author", with: "james saulter"
    fill_in "Url", with: "http://saulter.com"
    fill_in "Image url", with: "http://saulter.com"
    fill_in "Body", with: "1, 2, 3, 4 get your booty on the floor."
    fill_in "Slug", with: "my slug"
    select "Josh", from: "book_review[author_id]"
    check "coffee"
    check "Published"
  end

  def confirm_book_review_fields
    expect(page).to have_text("Hello World!")
    expect(page).to have_text("1, 2, 3, 4 get your booty on the floor.")
    expect(page).to have_text("my-slug")
    expect(page).to have_css(".published")
    expect(page).to have_text("Josh")
    expect(page).to have_text("coffee")
  end
end
