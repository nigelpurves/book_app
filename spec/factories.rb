FactoryGirl.define do
  factory :user do
    name      "Nigel Purves"
    email     "nigel@letengine.com"
    password  "foobar"
    password_confirmation "foobar"
  end
end