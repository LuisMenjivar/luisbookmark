require 'rails_helper'
feature "Topics" do 

  before(:each) do 
    @user = create(:user)
    manual_sign_in(@user)
  end

  scenario "User can browse through an index of his topics" do 
    topic = create(:topic, user: nil)
    visit topics_path
    expect(page).to have_css("h1", text: "Topics") 
    expect(page).not_to have_css("h4", text: topic.title) 
    topic.update(user: @user)
    visit topics_path
    expect(page).to have_css("h4", text: topic.title) 
  end

  scenario "user can browse through an index of his bookmarks" do 
    topic = create(:topic, user: @user.reload)
    bookmark = create(:bookmark, topic: topic)
    visit topics_path
    click_link(topic.title)
    expect(page).to have_css("a", text: bookmark.url)
  end
  scenario "User can create new topic" do 
    visit topics_path
    click_link("New Topic")
    fill_in 'Title', with: 'animals'
    click_button 'Create Topic'
    expect(current_path).to eq(topics_path)
    expect(page).to have_text "New topic successfully created!"
    expect(page).to have_css("h4", text: "animals")
  end

  scenario "user can edit a topic" do 
    topic = create(:topic, title: "animals", user: @user)
    visit topics_path
    click_link("animals")
    click_link("Edit Topic")
    expect(page).to have_field("topic_title", with: "animals", type: "text")
    fill_in "topic_title", with: "wild animals" 
    click_button("Update Topic")
    expect(page).to have_text("Topic successfully updated!")
    expect(page).to have_css("h4", text: "wild animals")
  end
   scenario "user can delete a topic" do 
     topic = create(:topic, title: "animals", user: @user)
     visit topics_path
     click_link(topic.title)
     click_link("Delete Topic")
     expect(page).to have_text("Topic successfully deleted!")
     visit topics_path
     expect(page).not_to have_css("h4", text: "animals")
   end
end



