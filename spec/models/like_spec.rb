require 'rails_helper'

RSpec.describe Like, :type => :model do
  context "associations" do
    it "belongs to user" do
      expect(Like.new).to belong_to(:user)
    end
    it "belongs to bookmark" do 
      expect(Like.new).to belong_to(:bookmark)
    end
  end
end