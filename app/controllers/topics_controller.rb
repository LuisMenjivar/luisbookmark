class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = current_user.topics
  end
  
  def show
    @topic_bookmarks = @topic.bookmarks
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  
  def topic_params
    params.require(:topic).permit(:title, :user_id)
  end
end
