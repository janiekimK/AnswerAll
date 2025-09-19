class User < ApplicationRecord
  has_secure_password

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: %w[user admin] }
  validates :password, length: { minimum: 12 }, if: -> { password.present? }

  before_validation :set_default_role, on: :create

  private

  def set_default_role
    self.role ||= 'user'
  end
end
