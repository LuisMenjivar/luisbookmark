require "rails_helper"

describe TopicPolicy do

  subject { described_class }

  before(:example) do 
    @user = create(:user)
    @topic = create(:topic, user: @user)
    @another_user = create(:user, email: "another@mail.com")
  end

  permissions :create? do
    it "does not allow visitors to create any topics"  do
      expect(subject).not_to permit(nil, @topic)
    end
    it "does not allow user to create another user's topics" do
      expect(subject).not_to permit(@another_user, Topic.create(user: @user))
    end
    it "allows user to create their own topics" do 
      expect(subject).to permit(@user, Topic.create(user: @user))
    end
  end

  permissions :index? do 
    it "does not allow visitors to index of any topics" do 
      expect(subject).not_to permit(nil, @topic)
    end
    it "does not allow users to another user topic index" do 
      expect(subject).not_to permit(@another_user, @topic)
    end
    it "allows user to view own topic index" do 
      expect(subject).to permit(@user, @topic)
    end
  end

  permissions :show? do 
    it "does not allow visitors to show of any topic" do 
      expect(subject).not_to permit(nil, @topic)
    end
    it "does not allow users to show another user show" do 
      expect(subject).not_to permit(@another_user, @topic)
    end
    it "allows user to view topic show" do 
      expect(subject).to permit(@user, @topic)
    end
  end

  permissions :update? do 
    it "does not allow visitor to update any topics" do 
      expect(subject).not_to permit(nil, @topic)
    end
    it "does not allow a user to update another user's topics" do 
      expect(subject).not_to permit(@another_user, @topic)    
    end
    it "allows user to update own topics" do 
      expect(subject).to permit(@user, @topic)
    end
  end

  permissions :destroy? do 
    it "does not allow a visitor to destroy any topics" do 
      expect(subject).not_to permit(nil, @topic)
    end
    it "not allow user to destroy another user's topic" do 
      expect(subject).not_to permit(@another_user, @topic)
    end
    it "allows user to destroy own topics" do 
      expect(subject).to permit(@user, @topic)
    end
  end
end