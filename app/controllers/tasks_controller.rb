# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :find_task, only: %i[show edit update destroy change_state]
  def index
    return @tasks = Task.order("#{params["time"]} ASC") if params["time"] === 'end_at'

    @tasks = Task.order("created_at DESC")
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, notice:t(:task_created)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to root_path, notice: t(:task_updated)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: t(:task_deleted)
  end

  def change_state
    return @task.start! redirect_to root_path if @task.state === 'to_be_started'
    return @task.finish! redirect_to root_path if @task.state === 'in_progress'
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :end_at, :priority)
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
