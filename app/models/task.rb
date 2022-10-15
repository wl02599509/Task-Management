# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 150 }

  def self.order_by(time = 'created_at')
    if time = 'end_at'
      self.order("end_at ASC")
    else
      self.order("created_at DESC")
    end
  end
end
