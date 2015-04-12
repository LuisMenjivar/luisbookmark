FactoryGirl.define do
  factory :bookmark do
    url "valid url"
    topic nil
    after(:build) do |bookmark| 
       bookmark.class.skip_callback(:save, :before, :set_image)
    end
  end
end