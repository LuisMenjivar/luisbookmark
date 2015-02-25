require 'rails_helper'

feature "user views topic index" do 
  scenario "only topics that belong to user" do 
    user = create(:user)
    topic = create(:topic, user_id: nil)
    manual_sign_in(user)
    visit topics_path
    expect(page).to have_css("h1", text: "Topics") 
    expect(page).not_to have_css("h4", text: "#{topic.title}") 
    topic.update(user_id: user.id)
    visit topics_path
    expect(page).to have_css("h4", text: "#{topic.title}") 
  end
end
