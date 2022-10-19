# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :user_sign_in?
  
  def current_user
    @current_user ||= User.find_by!(id: session[:current_user_id])
  end

  def user_sign_in?
    session[:current_user_id]
  end

  def authenticate_user!
    unless user_sign_in?
      redirect_to sign_in_users_path
    end
  end
end
