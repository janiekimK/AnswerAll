class User < ApplicationRecord
  has_secure_password

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy

  enum :role, { user: "user", admin: "admin" }, prefix: true

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :role, inclusion: { in: %w[user admin] }
  validates :password, length: { minimum: 12 }, if: -> { password.present? }

  before_validation :normalize_email
  before_validation :set_default_role, on: :create

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end

  def set_default_role
    self.role ||= 'user'
  end
end
