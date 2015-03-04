class BookmarksController < ApplicationController
  include Pundit
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:create_bookmark_from_mail]
  skip_before_action :verify_authenticity_token, only: [:create_bookmark_from_mail]
  
  def update
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.update(bookmark_params)
      redirect_to [@topic, @bookmark], notice: "Bookmark successfully updated!"
    else
      flash[:error] = "Error updating bookmark"
      render :edit
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.destroy
      redirect_to [@topic], notice: "Bookmark successfully deleted!"
    else 
      flash[:error] = "Error deleting bookmark"
    end 
  end

  def show
    @topic = Topic.find(params[:topic_id])
    @url = @bookmark.url
  end

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
        topic = Topic.create!(title: params[:subject], user: user)
      end
      Bookmark.create!(url: url, topic: topic)
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