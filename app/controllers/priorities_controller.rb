class PrioritiesController < ApplicationController
  def index
    @tasks = Task.where(user_id: current_user).order('priority ASC').page(params[:page]).per(5)
  end
end
