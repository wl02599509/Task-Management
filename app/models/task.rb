# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 150 }

  def self.order_by(time = 'created_at')
    self.order("#{time} DESC")
  end
end
