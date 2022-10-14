# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { Faker::Job.title }
    content { Faker::Job.field }

    trait :title_nil do
      title { nil }
    end
    trait :title_50 do
      title { Faker::Number.number(digits: 50) }
    end
    trait :title_51 do
      title { Faker::Number.number(digits: 51) }
    end

    trait :content_nil do
      content { nil }
    end
    trait :content_150 do
      content { Faker::Number.number(digits: 150) }
    end
    trait :content_151 do
      content { Faker::Number.number(digits: 151) }
    end
  end


  # trait :content_151 { content "#{Faker::Number.number(digits: 151)}" }
end
