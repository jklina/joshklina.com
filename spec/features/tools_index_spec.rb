require "rails_helper"

RSpec.feature "Tool reviews index page", :type => :feature do
  scenario "a visitor can view a book review" do
    book_review = create(:tool, title: 'My tool')

    visit tools_path

    expect(page).to have_text('My tool')
  end

  scenario "a visitor received a notification when there are no posts" do
    visit tools_path

    expect(page).to have_text(I18n.t("tools.index.no_tools_warning"))
  end

  it do
    paginates(factory: :tool,
              increment: 10,
              selector: '.tool',
              attributes:{published: true}) do
      visit tools_path
    end
  end
end
