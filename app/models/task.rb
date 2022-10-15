# frozen_string_literal: true

class Task < ApplicationRecord
  include AASM

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 150 }

  aasm column: 'state' do
    state :to_be_started, initial: true
    state :in_progress, :done

    event :start do
      transitions from: :to_be_started, to: :in_progress
    end

    event :finish do
      transitions from: :in_progress, to: :done      
    end

    event :back_to_start do
      transitions from: :in_progress, to: :to_be_started
    end

    event :back_to_progress do
      transitions from: :done, to: :in_progress
    end
  end
end
