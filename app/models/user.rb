class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {in: 10..50}

  enum role: %w(default admin)

  has_many :users_rewards
  has_many :rewards, through: :users_rewards
end