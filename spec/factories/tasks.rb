# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { Faker::Job.title }
    content { Faker::Job.field }
  end
end
