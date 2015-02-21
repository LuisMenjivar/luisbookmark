# This will guess the User class
FactoryGirl.define do
  factory :user do
    email        Faker::Internet.free_email
    password     Faker::Internet.password(8, 8)
    confirmed_at Time.now
  end
end