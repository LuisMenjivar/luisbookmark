require "rails_helper"
describe "Bookmarks request " do 
  it "creates a bookmark " do
    user = create(:user, email: "test@example.com")
    post '/bookmarks',{sender: "test@example.com", subject: "animals", "body-plain": "www.google.com"}
    expect(user.reload.topics).to match_array [Topic.find_by(title: "animals")]
    expect(user.topics.first.bookmarks).to match_array [Bookmark.find_by(url: "www.google.com")]
    expect(response.status).to eq(200)
  end
end
