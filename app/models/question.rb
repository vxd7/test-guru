class Question < ApplicationRecord
  belongs_to :test

  has_many :answers, dependent: :restrict_with_exception
end
