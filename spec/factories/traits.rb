FactoryGirl.define do
  trait :invalid do
    name nil
  end

  trait :updated do
    name "MyBucket"
  end
end
