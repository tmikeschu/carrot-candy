class Reward < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :quantity, presence: true
  validates :point_value, presence: true

  has_many :users_rewards
  has_many :users, through: :users_rewards
end