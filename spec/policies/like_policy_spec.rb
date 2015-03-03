require "rails_helper"

describe LikePolicy do

  subject { described_class }

  before(:example) do 
    @user = create(:user)
    @topic = create(:topic, user: @user)
    @bookmark = create(:bookmark, topic: @topic)
    @like = Like.create(user: @user, bookmark: @bookmark)
    @another_user = create(:user, email: "another@mail.com")
  end

  permissions :create? do
    it "does not allow visitors to create a like"  do
      expect(subject).not_to permit(nil, @like)
    end
    it "does not allow users to create another user's like" do
      expect(subject).not_to permit(@another_user, @like)
    end
    it "allows user to create a like" do 
      expect(subject).to permit(@user, @like)
    end
  end

  permissions :destroy? do 
    it "does not allows visitors to destroy a like" do 
      expect(subject).not_to permit(nil, @like)
    end
    it "does not allow users to destroy another user's like" do 
      expect(subject).not_to permit(@another_user, @like)
    end
    it "allows users to destroy their own like" do 
      expect(subject).to permit(@user, @like)
    end
  end
end