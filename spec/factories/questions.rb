FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }
    user { association :user }

    trait :invalid do
      title { nil }
    end
  end
end
