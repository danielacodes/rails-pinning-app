include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :category do
    name "rails"
  end

  sequence :slug do |n| 
    "slug#{n}"
  end

  factory :pin do
    title "Rails Cheatsheet"
    url "http://rails-cheat.com"
    text "A great tool for beginning developers"
    slug
    category
    image { fixture_file_upload(Rails.root.join('spec', 'photos', 'cup-kittes.jpg'), 'image/jpg') } 
  end

  factory :user do 
    sequence(:email) { |n| "coder#{n}@skillcrush.com" }
    first_name "Skillcrush"
    last_name "Coder"
    password "secret"
    after(:create) do |user|
      create_list(:pin, 3)
    end
  end

end  