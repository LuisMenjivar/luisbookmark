require 'rails_helper'

RSpec.describe User, :type => :model do
  context "associations" do 
    it "has many topics" do
      expect(User.new).to have_many(:topics)
    end
    it "has many likes" do 
      expect(User.new).to have_many(:likes)
    end
  end
end