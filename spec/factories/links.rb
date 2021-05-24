FactoryBot.define do
  factory :link do
    name { "MyString" }
    url { 'http://www.artstation.com/'}

    trait :linkable do
      association :linkable, factory: :answer
    end

    trait :valid_gist do
      url { 'https://gist.github.com/YaponEran/f10759463dfbd9eba45ea543c80ffa39' }
    end

    trait :invalid_gist do
      url { 'https://gist.github.com/YaponEran/' }
    end
  end
end
