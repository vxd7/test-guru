class UserBadge < ApplicationRecord
  belongs_to :user
  belongs_to :badge
  validates :rule, presence: true, uniqueness: { message: 'rule should be unique' }
end
