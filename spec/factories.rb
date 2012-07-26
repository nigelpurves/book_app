FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :artist do
    name "Radiohead"
  end
  
  factory :track do |f|
    f.association :artist
    name "Codex"
  end
  
  factory :interest do |f|
    f.association :track
    f.association :user
  end
end