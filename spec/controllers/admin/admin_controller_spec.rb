require 'rails_helper'

RSpec.describe Admin::AdminController, type: :controller do
  describe "#authorize" do
    it { should use_before_action(:authorize) }

    it "raises a 404 error if there is no logged in user" do
      expect { controller.authorize }.
        to raise_error(ActionController::RoutingError)
    end

    it "does not raise a 404 error if there is a logged in user" do
      allow(controller).to receive(:logged_in?).and_return(true)

      expect { controller.authorize }.not_to raise_error()
    end
  end

  describe "#current_user" do
    context "when logged in via a session" do
      it "returns the logged in user" do
        user = create(:user,
                      password: 'password',
                      email: 'j@j.com',
                      name: 'Josh')
        session_params = {user_id: user.id}
        allow(controller).to receive(:session).and_return(session_params)

        expect(controller.current_user).to eq(user)
      end
    end


    context "when logged in via a cookie" do
      it "returns the logged in user and sets the user_id in the session" do
        user = create(:user,
                      password: 'password',
                      email: 'j@j.com',
                      name: 'Josh')
        user.set_encrypted_remember_token!
        session_params = {}
        signed_cookie_params = {user_id: user.id}
        cookie_params = {remember_token: user.remember_token}
        fake_cookie = FakeCookies.new(
          signed: signed_cookie_params,
          unsigned: cookie_params
        )
        allow(controller).to receive(:cookies).and_return(fake_cookie)
        allow(controller).to receive(:session).and_return(session_params)

        expect(controller.current_user).to eq(user)
        expect(session_params[:user_id]).to eq(user.id)
      end
    end

    describe "#logged_in?" do
      it "returns true if current_user is present" do
        user = double("user")
        allow(controller).to receive(:current_user).and_return(user)

        expect(controller.logged_in?).to be_truthy
      end

      it "returns false if current_user is not present" do
        allow(controller).to receive(:current_user).and_return(nil)

        expect(controller.logged_in?).to be_falsey
      end
    end

    class FakeCookies
      def initialize(unsigned:{}, signed:{})
        @signed = signed
        @unsigned = unsigned
      end

      def [](key)
        @unsigned[key]
      end

      def signed
        @signed
      end
    end
  end
end
