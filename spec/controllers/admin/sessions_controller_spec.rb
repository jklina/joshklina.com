require 'rails_helper'

RSpec.describe Admin::SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "finds the user by the session email" do
      user = create(:user, email: 'user@user.com', password: 'password')

      post :create, session: {email: user.email, password: user.password}
      expect(response).to redirect_to(admin_posts_path)
    end

    it "generates an error message with incorrect login credentials" do
      post :create, session: {email: '', password: ''}

      expect(flash[:error]).to be_present

      get :new

      expect(flash[:error]).to_not be_present
    end
  end

  describe "DELETE #destroy" do
    it "deletes the sesssion and cookies" do
      build_user_and_login
      session['user_id'] = 1
      request.cookies['user_id'] = 1
      request.cookies['remember_token'] = 'token'

      delete :destroy

      expect(session['user_id']).to be_nil
      expect(cookies['user_id']).to be_nil
      expect(cookies['remember_token']).to be_nil
    end
  end
end
