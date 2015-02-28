class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to topics_path, notice: "New topic successfully created!"
    else 
      flash[:error] = "Error creating Topic"
      render :new
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to topics_path, notice: "Topic successfully updated!"
    else
      flash[:error] = "Error updating Topic"
      render :edit
    end
  end

  def destroy
    if @topic.destroy
      redirect_to topics_path, notice: "Topic successfully deleted!"
    else 
      flash[:error] = "Error deleting Topic"
    end
  end
  
  def index
    @topics = current_user.topics
  end

  def new
    @topic = Topic.new
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  
  def topic_params
    params.require(:topic).permit(:title, :user_id)
  end
end
