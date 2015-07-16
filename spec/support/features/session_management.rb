module Features
  module SessionManagement
    def create_user_and_login
      user = create(:user)
      login_as(user)
    end

    def login_as(user)
      visit admin_login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_on I18n.t("sessions.submit")
      return user
    end
  end
end

