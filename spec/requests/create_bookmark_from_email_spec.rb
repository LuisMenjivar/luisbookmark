require "rails_helper"
describe "Bookmarks request " do 

  before(:example) do |example|
    unless example.metadata[:skip_before]
      @user = create(:user, email: "test@example.com")
    end
  end

  it "creates a topic and a bookmark " do
    post '/bookmarks',{sender: "test@example.com", subject: "animals", "body-plain": "www.google.com"}
    expect(@user.reload.topics).to match_array [Topic.find_by(title: "animals")]
    expect(@user.topics.first.bookmarks).to match_array [Bookmark.find_by(url: "www.google.com")]
    expect(response.status).to eq(200) 
  end
  it "creates a bookmark if topic already exists" do
    topic = create(:topic, title: "animals", user: @user)
    post '/bookmarks',{sender: "test@example.com", subject: "animals", "body-plain": "www.google.com"}
    expect(@user.topics.first.bookmarks.first).to belong_to(:topic)
  end
  it "does not create a topic nor a bookmark if user does not exists", :skip_before do
    post '/bookmarks',{sender: "test@example.com", subject: "animals", "body-plain": "www.google.com"}
    expect(Topic.all.count).to eq(0)
    expect(Bookmark.all.count).to eq(0)
    expect(response.status).to eq(200) 
  end
  it "does not create a bookmark without a topic" do 
    expect{post '/bookmarks',{sender: "test@example.com", subject: "", "body-plain": "www.google.com"}
       }.to raise_error(ActiveRecord::RecordInvalid)
  end
  it "does not create an empty bookmark" do 
    expect{post '/bookmarks',{sender: "test@example.com", subject: "animals", "body-plain": ""}
      }.to raise_error(ActiveRecord::RecordInvalid)    
  end
end
