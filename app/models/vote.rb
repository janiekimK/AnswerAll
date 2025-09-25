class Vote < ApplicationRecord
  audited

  belongs_to :user
  belongs_to :answer

  validates :value, inclusion: { in: [1] }
  validates :user_id, uniqueness: { scope: :answer_id, message: "kann nur einmal voten" }
end
