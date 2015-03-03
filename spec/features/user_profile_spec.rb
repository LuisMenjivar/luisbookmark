require 'rails_helper'
describe "user profile" do 

  before(:example) do 
    @user = create(:user)
    @topic = create(:topic, user: @user)
    @bookmark = create(:bookmark, topic: @topic)
    manual_sign_in(@user)
    visit user_path(@user)
  end

  it "displays a user's Topics" do 
    expect(page).to have_css("h1", text: "#{@topic.title}")
    expect(page).to have_css("h1", count: @user.topics.count) 
  end
  it "displays a user's bookmarks" do 
    expect(page).to have_css("h4", text: "#{@bookmark.url}")
  end
  it "allows user to like their bookmarks" do 
    click_link("Like")
    expect(page).to have_link("Unlike")
    expect(@user.likes.count).to eq(1)
  end
  it "allows user to unlike bookmark" do 
    click_link("Like")
    click_link("Unlike")
    expect(page).to have_link("Like")
    expect(@user.likes.count).to eq(0)
  end
end
