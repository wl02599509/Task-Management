class PrioritiesController < ApplicationController
  def index
    @tasks = Task.order('priority ASC').page(params[:page]).per(5)
  end
end
