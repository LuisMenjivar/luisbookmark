require 'rails_helper'

RSpec.describe Topic, :type => :model do
  context "associations" do 
    it "belong to user" do 
      expect(Topic.new).to belong_to(:user)
    end
    it "has many bookmarks" do 
      expect(Topic.new).to have_many(:bookmarks)
    end
  end
  context "validations" do 
    it "validates presence of title" do 
      expect{Topic.create!}.to raise_error(ActiveRecord::RecordInvalid)
      expect(Topic.all.count).to eq(0)
    end
  end
end