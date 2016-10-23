FactoryGirl.define do
  factory :list do
    name "MyBucketList"
    user

    factory :list_with_items do
      after(:create) do |list|
        list.items << create_list(:item, 3)
      end
    end
  end
end
