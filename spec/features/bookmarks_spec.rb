require "rails_helper"
feature "boomarks" do 
  before(:each) do 
    @user = create(:user)
    @topic = create(:topic, user: @user)
    @bookmark = create(:bookmark, topic: @topic)
    manual_sign_in(@user)
  end
  scenario "user can see boomarks index" do 
    visit topic_path(@topic)
    expect(page).to have_css("h4", text: "#{@topic.bookmarks.first.url}")
  end
  scenario "user can create a bookmark" do 
    visit topic_path(@topic)
    click_link("New Bookmark")
    fill_in "bookmark_url", with: "www.google.com"
    click_button("Create Bookmark")
    visit topic_path(@topic)
    expect(page).to have_css("h4", text: "www.google.com")
  end

  scenario "user can edit a boomark" do 
  end

  scenario "user can delete a boomark" do 
  end
end