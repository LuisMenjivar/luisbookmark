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
  xit "creates a bookmark if topic already exists" do
  end
  xit "does not create a topic nor a bookmark if user does not exists" do 
  end
  xit "does not create a bookmark without a topic" do 
  end
  xit "does not create an empty bookmark" do 
  end
end
