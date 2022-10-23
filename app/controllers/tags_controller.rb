class TagsController < ApplicationController
  before_action :find_tag, only: %i[show destroy]

  def show
    @tasks = []
    TaskTag.where("tag_id": params[:id]).each do |task_tags|
      @tasks << task_tags.task_id
    end
  end
  
  def new
    @tag = Tag.new
  end
  
  def create
    @existing_tag = Tag.find_by(:title => params[:tag][:title])
    @task = Task.find(params[:task_id])
    
    if @existing_tag != nil
      @task.tags << @existing_tag
    else
      @task.tags.create(tag_params)
    end

    redirect_to root_path
  end
  
  def destroy
    @task_tag = TaskTag.find_by(:task_id => params[:task_id], :tag_id => params[:id])
    @task_tag.destroy
    redirect_to root_path
  end
  
  private

  def tag_params
    params.require(:tag).permit(:title)
  end
  
  def find_tag
    @tag = Tag.find(params[:id])
  end
end
