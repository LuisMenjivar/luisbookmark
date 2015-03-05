module ApplicationHelper
  def find_type(url)
    api_key = Rails.application.secrets.embedly_api_key
    embedly_api = Embedly::API.new(key: api_key)
    obj = embedly_api.oembed :url => url
    obj.first.type
  end
  def embed_media(url, size)
    api_key = Rails.application.secrets.embedly_api_key
    embedly_api = Embedly::API.new(key: api_key)
    obj = embedly_api.oembed :url => url, :width => size
    if obj.first.type == 'video'
      raw(obj.first.html)
    else
      raw(obj.first.thumbnail_url) 
    end
  end
  def embed_description(url)
    api_key = Rails.application.secrets.embedly_api_key
    embedly_api = Embedly::API.new(key: api_key)
    obj = embedly_api.oembed :url => url
    raw(obj.first.title)
  end
end