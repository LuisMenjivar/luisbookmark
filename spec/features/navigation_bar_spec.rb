require 'rails_helper'
feature "Navigation bar" do 
  before(:example) do |example|
    unless example.metadata[:skip_sign_in]
      @user = create(:user)
      manual_sign_in(@user)
      visit root_path
    end
  end

  scenario "has appropriate links for anonymous users", :skip_sign_in do 
    visit root_path
    expect(page).to have_link("Home")
    expect(page).to have_link("Sign in") 
    expect(page).to have_link("Sign up")
  end
  scenario "has appropriate links for signed in users " do 
    expect(page).to have_link("Home")
    expect(page).to have_link("Sign out") 
    expect(page).to have_link("Account")
    expect(page).to have_link("Topics")
    expect(page).to have_link("Profile")
  end
end