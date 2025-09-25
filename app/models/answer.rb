class Answer < ApplicationRecord
  audited

  belongs_to :user
  belongs_to :question
  has_many :votes, dependent: :destroy

  validates :description, presence: true
end
