class Admin::TasksController < Admin::AdminsContrtoller
  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks
  end
end
