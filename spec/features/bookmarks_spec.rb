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
    expect(page).to have_xpath("//img[contains(@src, @bookmark.url)]")
  end
  scenario "user can create a bookmark" do 
    visit topic_path(@topic)
    click_link("New Bookmark")
    fill_in "bookmark_url", with: "www.google.com"
    click_button("Save")
    visit topic_path(@topic)
    expect(page).to have_xpath("//img[contains(@src, @bookmark.image)]")
  end

  scenario "user can view a boomark" do 
    visit topic_path(@topic)
    click_link("Show")
    expect(page).to have_css("p", text: "")
  end
  scenario "user can edit a given bookmarks" do 
    visit topic_path(@topic)
    click_link("Show")
    click_link("Edit Bookmark")
    expect(page).to have_field("bookmark_url", with: "valid url", type: "url")
    fill_in "bookmark_url", with: "www.google.com"
    click_button("Save")
    expect(page).to have_link("www.google.com")
    expect(page).not_to have_link("valid url")
  end

  scenario "user can delete a boomark" do 
    visit topic_path(@topic)
    click_link("Show")
    click_link("Delete Bookmark")
    expect(page).to have_text("Bookmark successfully deleted!")
    expect(page).not_to have_css("a", text: @bookmark.url)
  end
end