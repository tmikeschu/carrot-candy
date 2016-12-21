class Reward < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :quantity, presence: true
  validates :point_value, presence: true
end