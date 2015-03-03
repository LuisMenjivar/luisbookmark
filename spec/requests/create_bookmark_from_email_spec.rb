require "rails_helper"
describe "Bookmarks request " do 

  before(:example) do |example|
    unless example.metadata[:skip_before]
      @user = create(:user, email: "test@example.com")
    end
  end

  it "creates a topic and a bookmark " do
    post '/bookmarks',{sender: "test@example.com", subject: "animals", "body-plain": "www.google.com\r\n"}
    expect(@user.reload.topics).to match_array [Topic.find_by(title: "animals")]
    expect(@user.topics.first.bookmarks).to match_array [Bookmark.find_by(url: "www.google.com")]
    expect(response.status).to eq(200) 
  end
  it "creates a bookmark if topic already exists" do
    topic = create(:topic, title: "animals", user: @user)
    expect(@user.topics.count).to eq(1)
    post '/bookmarks',{sender: "test@example.com", subject: "animals", "body-plain": "www.google.com\r\n"}
    expect(Bookmark.find_by_url("www.google.com").topic).to eq(topic)
    expect(@user.topics.count).to eq(1)
    expect(response.status).to eq(200)
  end
  it "does not create a topic nor a bookmark if user does not exists", :skip_before do
    post '/bookmarks',{sender: "test@example.com", subject: "animals", "body-plain": "www.google.com\r\n"}
    expect(Topic.all.count).to eq(0)
    expect(Bookmark.all.count).to eq(0)
    expect(response.status).to eq(200) 
  end
  it "does not create a bookmark without a topic" do 
    expect{post '/bookmarks',{sender: "test@example.com", subject: "", "body-plain": "www.google.com\r\n"}
       }.to raise_error(ActiveRecord::RecordInvalid)
  end
  it "does not create an empty bookmark" do 
    expect{post '/bookmarks',{sender: "test@example.com", subject: "animals", "body-plain": "\r\n"}
      }.to raise_error(ActiveRecord::RecordInvalid)    
  end
end
