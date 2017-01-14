require "rails_helper"

RSpec.feature "Tool management", :type => :feature do
  scenario "user can view tools" do
    user = create_user_and_login
    tool = create(:tool, published: true, title: 'My Title is Good')

    visit admin_tools_path

    expect(page).to have_text(tool.body)
  end


  it do
    create_user_and_login
    paginates(factory: :tool,
              increment: 25,
              selector: '.tool',
              attributes:{published: true}) do
      visit admin_tools_path
    end
  end

  scenario "user can edit tools" do
    user = create_user_and_login(name: 'Andrew')
    tool = create(:tool, title: 'My Title')
    tag = create(:tag, label: 'coffee')

    visit edit_admin_tool_path(tool)

    expect(find_field('Title').value).to eq('My Title')
    expect(page).to have_text(tool.body)

    fill_in_tool_form
    click_on "Update Tool"

    confirm_tool_fields
  end

  scenario "user can create tools " do
    user = create_user_and_login(name: 'Andrew')
    tag = create(:tag, label: 'coffee')

    visit new_admin_tool_path
    fill_in_tool_form
    click_on "Create Tool"

    confirm_tool_fields
    expect(page).to have_text("Tool successfully created.")
  end

  scenario "user can fix invalid tools" do
    user = create_user_and_login
    visit new_admin_tool_path

    fill_in "Title", with: ""
    fill_in "Body", with: "1, 2, 3, 4 get your booty on the floor."
    click_on "Create Tool"

    expect(page).to have_text("Title can't be blank")
    expect(page).to have_text("1, 2, 3, 4 get your booty on the floor.")
  end

  def fill_in_tool_form
    fill_in "Title", with: "Hello World!"
    fill_in "Url", with: "http://saulter.com"
    fill_in "Body", with: "1, 2, 3, 4 get your booty on the floor."
    fill_in "Slug", with: "my slug"
    check "coffee"
    check "Published"
  end

  def confirm_tool_fields
    expect(page).to have_text("Hello World!")
    expect(page).to have_text("1, 2, 3, 4 get your booty on the floor.")
    expect(page).to have_text("my-slug")
    expect(page).to have_css(".published")
    expect(page).to have_text("coffee")
  end
end
