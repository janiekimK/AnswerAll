class Question < ApplicationRecord
  audited

  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
end
