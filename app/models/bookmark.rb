class Bookmark < ActiveRecord::Base
  validates :url, presence: true
  belongs_to :topic
  has_many :likes, dependent: :destroy
  before_save :set_image
  has_attached_file :image, :styles => { :thumb => "100x100>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  private
  def set_image
    api_key = Rails.application.secrets.embedly_api_key
    embedly_api = Embedly::API.new(key: api_key)
    embedly_results = (embedly_api.extract :url => self.url).first
    if embedly_results.images.first
      self.image = embedly_results.images.first['url']
    else
      self.image = "https://avatars2.githubusercontent.com/u/8715390?v=3&s=400"
    end 
    self.image_file_name = embedly_results.title if !embedly_results.title.nil? 
  end
end