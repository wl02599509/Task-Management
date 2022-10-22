class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  after_validation :encrypt
  before_destroy :must_one_admin

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  validates :name, presence: true
  validates :email, presence: true, 
                    uniqueness: true, 
                    format: { with: EMAIL_REGEX }
  validates :password,  presence: true, 
                        confirmation: true,  
                        length: { minimum: 8 }
  validates :password_confirmation, presence: true

  # admin 設定 99，以防誤設定。
  enum role: { admin: '99', user: '1' }

  def self.sign_in(user_params)
    email = user_params[:email]
    password = user_params[:password]
    encrypt_password = Digest::SHA2.hexdigest "#{password}t8A3s@K7y!O-u$R%s%ElF"
    find_by(email: email, password: encrypt_password)
  end
  
  private

  def must_one_admin
    if User.where(:role => '99').count === 1
      throw(:abort)
    end
  end

  def encrypt
    password_in_system = "#{self.password}t8A3s@K7y!O-u$R%s%ElF"
    self.password = Digest::SHA2.hexdigest password_in_system
  end
end
