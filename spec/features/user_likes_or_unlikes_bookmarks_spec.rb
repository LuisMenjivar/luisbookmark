require 'rails_helper'
feature "user" do 
  before(:each) do
    @user = create(:user)
    @topic = create(:topic, user: @user)
    @bookmark = create(:bookmark, topic: @topic)
    manual_sign_in(@user)
  end
  scenario "likes a bookmark" do 
    visit topic_path(@topic)
    click_link("Like")
    expect(page).to have_link("Unlike")
    expect(@user.likes.all.count).to eq(1)
  end
  scenario "unlikes a bookmark" do 
    visit topic_path(@topic)
    click_link("Like")
    click_link("Unlike")
    expect(page).to have_link("Like")
    expect(@user.likes.all.count).to eq(0)
  end
end
