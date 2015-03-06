require 'rails_helper'

RSpec.describe Bookmark, :type => :model do
  context "associations" do 
    it "belongs to topic" do 
      expect(Bookmark.new).to belong_to(:topic)
    end
    it "has many likes" do 
      expect(Bookmark.new).to have_many(:likes)
    end
  end
  context "attributes" do
    it "has image " do 
      expect(Bookmark.new).to have_attributes(image_file_name: nil, image_content_type: nil,
        image_file_size: nil) 
    end
  end 
end