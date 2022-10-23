class TagsController < ApplicationController
  before_action :find_tag, only: %i[show edit update destroy]
  def index
    @tags = Tag.all
  end
  
  def show; end
  
  def new
    @tag = Tag.new
  end
  
  def create
    @tag = Tag.create(tag_params)
    redirect_to root_path
  end
  
  def edit; end
  
  def update
    if @tag.update(tag_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  
  def destroy
    @tag.destroy
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
