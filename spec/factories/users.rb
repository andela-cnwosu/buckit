FactoryGirl.define do
  factory :user do
    first_name "Chinese"
    last_name "Nwosu"
    email "user@gmail.com"
    password "password"
    password_confirmation "password"
  end

  trait :user_invalid do
    email "usergmail.com"
    password "password"
  end

  trait :login_valid do
    email "user@gmail.com"
    password "password"
  end
end
