require 'rails_helper'
feature "Navigation bar" do 
  before(:example) do |example|
    unless example.metadata[:skip_before]
      @user = create(:user)
      manual_sign_in(@user)
      visit root_path
    end
  end

  scenario "has sign in link, sign up link, and home link when user is not signed in", :skip_before do 
    visit root_path
    expect(page.body).to have_link("Home")
    expect(page.body).to have_link("Sign in") 
    expect(page.body).to have_link("Sign up")
  end
  scenario "has topics, account, and sign out link when user is signed in " do 
    expect(page.body).to have_link("Home")
    expect(page.body).to have_link("Sign out") 
    expect(page.body).to have_link("Account")
    expect(page.body).to have_link("Topics")
  end
end