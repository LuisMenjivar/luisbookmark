class Bookmark < ActiveRecord::Base
  validates :url, presence: true
  belongs_to :topic
  has_many :likes, dependent: :destroy
  has_attached_file :image, :styles => { :thumb => "100x100>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end