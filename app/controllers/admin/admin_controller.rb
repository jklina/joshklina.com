class Admin::AdminController < ApplicationController
  layout 'admin'

  before_action :authorize
  helper_method :current_user, :logged_in?

  def authorize
    raise ActionController::RoutingError.new('Not Found') unless logged_in?
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        session[:user_id] = user.id
        @current_user = user
      end
    end
  end

  def logged_in?
    current_user.present?
  end

end
