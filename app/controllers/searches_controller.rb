class SearchesController < ApplicationController
  def index
    @tasks = Task.search(params["task"]["keyword"]).page(params[:page]).per(10)
  end
end
