class User < ApplicationRecord
  has_many :tasks

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
end
