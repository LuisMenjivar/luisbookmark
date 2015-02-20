require 'rails_helper'
feature "User signs up for acount" do 
  scenario "successfuly" do 
   visit new_user_registration_path
   fill_in 'Email', with: "test@example.com"
   fill_in 'Password', with: "helloworld"
   fill_in 'Password confirmation', with: "helloworld"
   click_button 'Sign up'
  end  
end