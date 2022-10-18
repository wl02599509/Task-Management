class SearchesController < ApplicationController
  def index
    @tasks = Task.search(params["task"]["keyword"], current_user).page(params[:page]).per(10)
  end
end
