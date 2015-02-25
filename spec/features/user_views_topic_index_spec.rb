require 'rails_helper'
feature "Topics" do 

 before(:each) do 
    @user = create(:user)
    manual_sign_in(@user)
 end

  scenario "User can browse through an index of his topics" do 
    topic = create(:topic, user_id: nil)
    visit topics_path
    expect(page).to have_css("h1", text: "Topics") 
    expect(page).not_to have_css("h4", text: "#{topic.title}") 
    topic.update(user_id: @user.id)
    visit topics_path
    expect(page).to have_css("h4", text: "#{topic.title}") 
  end

  scenario "user can browse through an index of his bookmarks" do 
    topic = create(:topic, user_id: @user.reload.id)
    bookmark = create(:bookmark, topic_id: topic.id)
    visit topics_path
    click_link("#{topic.title}")
    expect(page).to have_css("a", text: "#{bookmark.url}")
  end
end



