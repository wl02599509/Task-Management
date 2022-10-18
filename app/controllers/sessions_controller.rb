class SessionsController < ApplicationController
  def create
    user = User.login(params[:user])
    if user 
      session[:current_user_id] = user.id

      redirect_to root_path, notice: I18n.t(:user_sign_in)
    else
      render :sign_in, status: :unprocessable_entity
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to sign_in_users_path, notice: I18n.t('user_sign_out')
  end
end
