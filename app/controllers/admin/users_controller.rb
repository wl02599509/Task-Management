class Admin::UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update destroy]

  def index
    @users = User.page(params[:page]).per(5)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: I18n.t('user_created')
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit; end
  
  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
    end

    if @user.update(user_params)
      redirect_to admin_users_path, notice: I18n.t('user_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    session[:current_user_id] = nil
    @user.destroy
    redirect_to admin_users_path, status: :see_other, notice: I18n.t('user_deleted')
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
  
  def find_user
    @user = User.find(params[:id])
  end
end
