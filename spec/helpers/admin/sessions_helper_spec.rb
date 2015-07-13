require 'rails_helper'

RSpec.describe Admin::SessionsHelper, type: :helper do
  describe "#current_user" do
    context "when logged in via a session" do
      it "returns the logged in user" do
        user = create(:user,
                      password: 'password',
                      email: 'j@j.com',
                      name: 'Josh')
        session_params = {user_id: user.id}
        allow(helper).to receive(:session).and_return(session_params)

        expect(helper.current_user).to eq(user)
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

        expect(helper.current_user).to eq(user)
        expect(session_params[:user_id]).to eq(user.id)
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
