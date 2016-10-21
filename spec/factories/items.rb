FactoryGirl.define do
  factory :item do
    name "MyBucketItem"
    list
  end

  trait :done do
    done true
  end
end
