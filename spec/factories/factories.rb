FactoryGirl.define do
  factory :user do 
    sequence(:email) { |n| "coder#{n}@skillcrush.com" }
    first_name "Skillcrush"
    last_name "Coder"
    password "secret"
  end

  factory :pin do 
    sequence(:slug) { |n| "awesome#{n}-slug" }
    title "Rails Wizard"
    url "http://railswizard.org"
    text "A fun and helpful Rails Resource"
    category_id 1
  end
end  