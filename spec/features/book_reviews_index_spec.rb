require "rails_helper"

RSpec.feature "Book reviews index page", :type => :feature do
  scenario "a visitor can view a book review" do
    book_review = create(:book_review, book_title: 'Book Review')

    visit book_reviews_path

    expect(page).to have_text('Book Review')
  end

  scenario "a visitor received a notification when there are no posts" do
    visit book_reviews_path

    expect(page).to have_text(I18n.t("book_reviews.index.no_reviews_warning"))
  end

  it do
    paginates(model: BookReview,
              increment: 10,
              selector: 'article',
              model_attributes:{published: true}) do
      visit book_reviews_path
    end
  end
end
