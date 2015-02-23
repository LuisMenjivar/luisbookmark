class BookmarksController < ApplicationController


  def create_bookmark
  
    @bookmark = Bookmark.create!(title: "this was created by the mail sent")
    
    render nothing: true  
  end


end
