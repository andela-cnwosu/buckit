FactoryGirl.define do
  factory :list do
    name "MyBucketList"
    user

    trait :invalid do
      name nil
      user
    end

    factory :updated_list do
      name "MyBucket"
      user
    end
  end
end
