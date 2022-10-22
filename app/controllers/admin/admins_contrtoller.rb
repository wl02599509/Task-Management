class Admin::AdminsContrtoller < ApplicationController
  before_action :admin_only

  private

  def admin_only
    if current_user.role != 'admin'
      redirect_to root_path, notice: I18n.t('permission_denied')
    end
  end
end