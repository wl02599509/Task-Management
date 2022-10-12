class TasksController < ApplicationController
  before_action :find_task, only: %i[show edit update destroy]
  def index
    @tasks = Task.all
  end
  
  def show; end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, notice:'Task created.'
    else
      render :new
    end
  end
  
  def edit; end
  
  def update
    if @task.update(task_params)
      redirect_to root_path, notice: 'Task updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    redirect_to root_path, notice: 'Task destroyed.'
  end
  
  private
  def task_params
    params.require(:task).permit(:title, :content)
  end
  
  def find_task
    @task = Task.find(params[:id])
  end
end
