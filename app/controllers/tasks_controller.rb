# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :find_task, only: %i[show edit update destroy change_state]
  before_action :authenticate_user!

  def index
    if params["time"] === 'end_at'
      @tasks = Task.where(user_id: current_user).order("#{params["time"]} ASC").page(params[:page]).per(5)
      return
    end

    @tasks = Task.where(user_id: current_user).order("created_at DESC").page(params[:page]).per(5)
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to root_path, notice: I18n.t(:task_created)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to root_path, notice: I18n.t(:task_updated)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, status: :see_other, notice:  I18n.t(:task_deleted)
  end

  def change_state
    return @task.start! redirect_to root_path, notice: I18n.t('state_changed') if @task.state === 'to_be_started'
    
    return @task.finish! redirect_to root_path, notice: I18n.t('state_changed') if @task.state === 'in_progress'
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :end_at, :priority)
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
