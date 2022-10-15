class SearchesController < ApplicationController
  def index
    @tasks = Task.search(params["task"]["keyword"]) if params["task"]
  end
end
