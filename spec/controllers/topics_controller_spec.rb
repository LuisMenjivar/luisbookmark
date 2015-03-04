require 'rails_helper'
include Devise::TestHelpers
describe TopicsController do 
  before(:example) do 
    @victim_topic = create(:topic, title: "@victim's topic")
    @user = create(:user)
    @user_topic = create(:topic, user: @user, title: "@user's topic")
    sign_in @user
  end
  describe "#destroy" do 
    it "does not destroy another users topic" do
      expect { delete :destroy, id: @victim_topic.id }.to raise_error(ActiveRecord::RecordNotFound)
      expect(@victim_topic.reload.persisted?).to eq(true)
    end
    it "destroys a user's topic" do 
      expect(@user.topics.count).to eq(1)
      expect {delete :destroy, id: @user_topic.to_param}.not_to raise_error
      expect(@user.topics.count).to eq(0)
    end
  end

  describe "#update" do 
    it "does not update another users topic" do   
      expect{patch :update, {id: @victim_topic.reload.to_param, topic: {title: "Let's try and update this title" } }
        }.to raise_error(ActiveRecord::RecordNotFound)
      expect(@victim_topic.reload.title).to eq("@victim's topic")
    end
    it "updates a users topic" do
      expect(@user_topic.title).to eq("@user's topic")
      expect{patch :update, {id: @user_topic.reload.to_param, topic: {title: "Let's try and update this title" } }
          }.not_to raise_error
      expect(@user_topic.reload.title).to eq("Let's try and update this title")
    end
  end
end