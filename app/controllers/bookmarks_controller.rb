class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:create_bookmark_from_mail]
  skip_before_action :verify_authenticity_token, only: [:create_bookmark_from_mail]

  def new 
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new(bookmark_params)
    if @bookmark.save
      redirect_to topic_path(@topic), notice: "Bookmark successfully created!"
    else 
      flash[:error] = "Error creating Bookmark"
      render :new
    end
  end

  def create_bookmark_from_mail
    user = User.where(email: params[:sender]).first
  
    if user != nil 
       topic = Topic.where(title: params[:subject], user: user).first
       url = (params["body-plain"]).strip!
      if topic.nil?
        new_topic = Topic.create!(title: params[:subject], user: user)
        Bookmark.create!(url: url, topic: new_topic)
      else
        Bookmark.create!(url: url, topic: topic)
      end
      head 200
    else
      head 200 #Even though the bookmark nor the topic was created. It returns 200 so that mailgun does not keep resending the email
    end 

  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:topic_id, :url)
  end
end