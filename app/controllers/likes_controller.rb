class LikesController < ApplicationController
  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)
    
    if like.save
      flash[:notice] = "Bookmark was liked successfuly"
      redirect_to [@bookmark.topic]
    else
      flash[:error] = "Error liking this bookmark"
      redirect_to [@bookmark.topic]
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.find(params[:id])
    
    if like.destroy
      flash[:notice] = "Bookmark is not liked anymore"
      redirect_to [@bookmark.topic]
    else
      flash[:error] = "Error unliking this bookmark"
      redirect_to [@bookmark.topic]
    end
  end
end