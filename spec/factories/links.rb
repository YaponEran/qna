FactoryBot.define do
  factory :link do
    name { "MyString" }
    url { 'http://www.artstation.com/'}

    trait :linkable do
      association :linkable, factory: :answer
    end
  end
end
