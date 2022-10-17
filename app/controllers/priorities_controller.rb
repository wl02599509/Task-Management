class PrioritiesController < ApplicationController
  def index
    @tasks = Task.order('priority ASC')
  end
end
