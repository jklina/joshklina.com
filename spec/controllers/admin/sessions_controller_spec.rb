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

end