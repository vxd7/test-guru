class Badge < ApplicationRecord
  has_many :user_badges, dependent: :nullify
  has_many :users, through: :user_badges
  validates :rule, presence: true, uniqueness: { message: 'rule should be unique' }
end
