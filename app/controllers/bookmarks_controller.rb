class BookmarksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create_bookmark_from_mail]

  def create_bookmark_from_mail
    user = User.where(email: "#{params[:sender]}").first
  
    if user != nil 
       topic = Topic.where(title: "#{params[:subject]}", user_id: user.id).first
       url = params["body-plain"]
      if topic.nil?
        new_topic = Topic.create!(title: "#{params[:subject]}", user: user)
        Bookmark.create!(url: "#{url}", topic: new_topic)
      else
        Bookmark.create(url: "#{url}", topic: topic)
      end
      head 200
    else
      head 200 #Even though the bookmark nor the topic was created. It returns 200 so that mailgun does not keep resending the email
    end 

  end
end