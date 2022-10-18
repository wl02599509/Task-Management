class UsersController < ApplicationController
  def sign_up
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: I18n.t(:user_sign_up)
    else
      render :sign_up, status: :unprocessable_entity
    end
  end

  def sign_in
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
