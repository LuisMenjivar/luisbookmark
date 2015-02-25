class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = current_user.topics
  end
  
  private
  
  def set_topic
    params.require(:topic).permit(:title, :user_id)
  end
end
