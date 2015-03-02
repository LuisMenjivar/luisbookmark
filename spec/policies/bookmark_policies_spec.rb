require "rails_helper"

describe BookmarkPolicy do

  subject { described_class }

  before(:example) do 
    @user = create(:user)
    @topic = create(:topic, user: @user)
    @bookmark = create(:bookmark, topic: @topic)
    @another_user = create(:user, email: "another@mail.com")
  end

  permissions :create? do
    it "does not allow visitors to create any bookmarks"  do
      expect(subject).not_to permit(nil, @bookmark)
    end
    it "does not allow user to create another user's bookmark" do
      expect(subject).not_to permit(@another_user, @bookmark)
    end
    it "allows user to create their own bookmarks" do 
      expect(subject).to permit(@user, Bookmark.create(topic: @topic))
    end
  end

  permissions :index? do 
    it "does not allow visitors to index of any bookmarks" do 
      expect(subject).not_to permit(nil, @bookmarks)
    end
    it "does not allow users to another user index" do 
      expect(subject).not_to permit(@another_user, @bookmark)
    end
    it "allows user to view own bookmark index" do 
      expect(subject).to permit(@user, @bookmark)
    end
  end

  permissions :show? do 
    it "does not allow visitors to show of any bookmark" do 
      expect(subject).not_to permit(nil, @bookmark)
    end
    it "does not allow users to show another user show" do 
      expect(subject).not_to permit(@another_user, @bookmark)
    end
    it "allows user to view bookmark show" do 
      expect(subject).to permit(@user, @bookmark)
    end
  end

  permissions :update? do 
    it "does not allow visitor to update any bookmarks" do 
      expect(subject).not_to permit(nil, @bookmark)
    end
    it "does not allow a user to update another user's bookmarks" do 
      expect(subject).not_to permit(@another_user, @bookmark)    
    end
    it "allows user to update own bookmarks" do 
      expect(subject).to permit(@user, @bookmark)
    end
  end

  permissions :destroy? do 
    it "does not allow a visitor to destroy any bookmark" do 
      expect(subject).not_to permit(nil, @bookmark)
    end
    it "not allow user to destroy another user's bookmark" do 
      expect(subject).not_to permit(@another_user, @bookmark)
    end
    it "allows user to destroy own bookmark" do 
      expect(subject).to permit(@user, @bookmark)
    end
  end
end