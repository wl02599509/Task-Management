class SearchesController < ApplicationController
  def index
    @tasks = Task.search(params["task"]["keyword"])
  end
end
