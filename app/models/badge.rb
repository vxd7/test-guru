class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  validates :name, :picture, presence: true
  validates :rule, presence: true, uniqueness: { scope: :value }
end
