class Bookmark < ActiveRecord::Base
  validates :url, presence: true
  belongs_to :topic
  has_many :likes, dependent: :destroy
  after_validation :set_image
  has_attached_file :image, :styles => { :thumb => "100x100>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  private
  def set_image
    api_key = Rails.application.secrets.embedly_api_key
    embedly_api = Embedly::API.new(key: api_key)
    obj = embedly_api.extract :url => self.url
    if !obj.first.images.first.nil?
      self.image = obj.first.images.first['url']
    elsif !obj.first.favicon_url.nil?
      self.image = obj.first.favicon_url
    else
      self.image = "https://avatars2.githubusercontent.com/u/8715390?v=3&s=400"
    end  
    self.image_file_name = (obj.first.title).html_safe if !obj.first.title.nil?
    true
  end
end