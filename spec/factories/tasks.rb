# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    association :user 
    title { Faker::Job.title }
    content { Faker::Job.field }
    end_at { nil }

    #title_validation
    trait :title_nil do
      title { nil }
    end
    trait :title_50 do
      title { Faker::Number.number(digits: 50) }
    end
    trait :title_51 do
      title { Faker::Number.number(digits: 51) }
    end

    #content_validation
    trait :content_nil do
      content { nil }
    end
    trait :content_150 do
      content { Faker::Number.number(digits: 150) }
    end
    trait :content_151 do
      content { Faker::Number.number(digits: 151) }
    end

    #order
    trait :created_first_end_first do
      created_at { Time.now + 1.days }
      end_at { Time.now + 10.days } 
    end
    trait :created_last_end_last do
      created_at { Time.now + 3.days }
      end_at { Time.now + 12.days } 
    end

    #state
    trait :to_be_started do
      state { 'to_be_started' }
    end
    trait :in_progress do
      state { 'in_progress' }
    end

    trait :many_to_be_started do
      state { 'to_be_started' }
      after :create do
        create_list(:task, 5)
      end
    end
    trait :many_in_progress do
      state { 'in_progress' }
      after :create do
        create_list(:task, 5)
      end
    end
    trait :many_done do
      state { 'done' }
      after :create do
        create_list(:task, 5)
      end
    end

    #priority
    trait :high do
      priority { '0' }
    end
    trait :normal do
      priority { '1' }
    end
    trait :low do
      priority { '2' }
    end
  end
end
