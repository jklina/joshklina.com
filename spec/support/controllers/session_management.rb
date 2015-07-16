module Controllers
  module SessionManagement
    def create_user_and_login
      user = create(:user)
      fake_login_with(user)
    end


    def build_user_and_login
      user = build(:user)
      fake_login_with(user)
    end

    def fake_login_with(user)
      allow(controller).to receive(:current_user).and_return(user)
      return user
    end
  end
end

