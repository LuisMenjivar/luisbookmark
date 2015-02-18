require 'rails_helper'
feature "welcome page" do 
  scenario "application root to the welcome page" do 
    visit root_path
    expect(page).to have_text("Welcome to the best bookmark application there is on the web")
  end
end