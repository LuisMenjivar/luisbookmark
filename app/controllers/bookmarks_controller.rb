class BookmarksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create_bookmark_from_mail]

  def create_bookmark_from_mail
    @user = User.where(email: "#{params[:sender]}").first
    @topic = Topic.where(title: "#{params[:subject]}", user_id: @user.id).first
    @url = params["body-plain"]
    
    if @user != nil 
      
      if @topic.nil?
        @new_topic = Topic.create(title: "#{params[:subject]}", user_id: @user.id)
        Bookmark.create(url: "#{@url}", topic_id: @new_topic.id)
      else
        Bookmark.create(url: "#{@url}", topic_id: @topic.id)
      end
      head 200
    else
      head 202
    end 

  end
end