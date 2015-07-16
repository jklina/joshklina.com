
require "rails_helper"

RSpec.feature "Session management", :type => :feature do
  scenario "user gets error message with invalid credentials" do
    visit admin_login_path
    fill_in "Email", with: ''
    fill_in "Password", with: ''
    click_on I18n.t("sessions.submit")

    expect(page).to have_content(I18n.t("sessions.failed_login"))

    visit admin_login_path

    expect(page).to_not have_content(I18n.t("sessions.failed_login"))
  end

  scenario "user can log in" do
    user = create(:user, email: 'user@user.com',
                  password: 'password',
                  name: 'Josh')

    login_as(user)

    expect(current_path).to eq(admin_posts_path)
    expect(page).to have_content(I18n.t("sessions.destroy"))
  end

  scenario "user can log out" do
    user = create(:user, email: 'user@user.com',
                  password: 'password',
                  name: 'Josh')

    login_as(user)
    click_on(I18n.t("sessions.destroy"))

    expect(current_path).to eq(root_path)
  end
end
