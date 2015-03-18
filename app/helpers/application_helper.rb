module ApplicationHelper
  def embed_video(url, size)
    api_key = Rails.application.secrets.embedly_api_key
    embedly_api = Embedly::API.new(key: api_key)
    embedly_video = (embedly_api.oembed :url => url, :width => size).first
    if embedly_video.type == 'video'
      raw(embedly_video.html)
    else
      false
    end
  end
end