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
  
  factory :track do
    artist "Radiohead"
    name "Codex"
  end
  
  factory :interest do
    track_id { |i| "1+#{n}" }
    user
  end
end