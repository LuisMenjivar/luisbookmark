require 'rails_helper'
describe "user profile" do 
  it "displays a user's bookmarks" do 
    user = create(:user)
    visit user_path(user)
    
  end
  it "displays a user's topics " do 
  end
  it "allows user to like or unlike their bookmarks" do 
  end
end
