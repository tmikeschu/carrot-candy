class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {in: 10..50}, on: :create

  enum role: %w(default admin)

  has_many :users_rewards
  has_many :rewards, through: :users_rewards

  def name
    first_name + " " + last_name
  end

  def total_points
    points + redeemed_points
  end

  def redeemed_points
    rewards.sum(:point_value)
  end
end