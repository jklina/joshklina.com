class Admin::SessionsController < Admin::AdminController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.

      user.set_encrypted_remember_token!
      session[:user_id] = user.id
      cookies.permanent.signed[:user_id] = user.id
      cookies.permanent[:remember_token] = user.remember_token
      redirect_to admin_posts_path
    else
      flash.now[:error] = t("sessions.failed_login")
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    redirect_to root_url
  end
end
