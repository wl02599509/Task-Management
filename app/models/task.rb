# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 150 }
end
