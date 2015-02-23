require 'rails_helper'
feature "Navigation bar" do 
  scenario "has link sign in and home link when user is not signed on" do 
    visit root_path
    expect(page.body).to have_link("Home")
    expect(page.body).to have_link("Sign in") 
  end
  scenario "has account and sign out link when user is signed in " do 
    visit root_path
    user = create(:user)
    manual_sign_in(user)
    expect(page.body).to have_link("Home")
    expect(page.body).to have_link("Sign out") 
    expect(page.body).to have_link("Account")
    #body 
  end
end