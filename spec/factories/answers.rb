FactoryBot.define do
  factory :answer do
    body { "MyText" }
    point { 1 }
    accept { true }
    question { association :question }

    trait :invalid do
      body { nil }
    end
  end
end
