class User < ApplicationRecord
  has_many :tasks

  before_create :encrypt

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 8 }

  def self.login(user_params)
    email = user_params[:email]
    password = user_params[:password]
    encrypt_password = Digest::SHA2.hexdigest "#{password}t8A3s@K7y!O-u$R%s%ElF"
    find_by!(email: email, password: encrypt_password)
  end

  private

  def encrypt
    password_in_system = "#{self.password}t8A3s@K7y!O-u$R%s%ElF"
    self.password = Digest::SHA2.hexdigest password_in_system
  end
end
