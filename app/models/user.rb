class User < ApplicationRecord
  has_secure_password
  has_many :lists

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name,
            :last_name,
            :email,
            presence: true

  validates :email,
            uniqueness: true,
            format: EMAIL_REGEX

  validates :password,
            presence: true,
            confirmation: true,
            length: { minimum: 6 }

  before_save :downcase_email

  private

  def full_name
    "#{first_name} #{last_name}"
  end

  def downcase_email
    self.email.downcase!
  end
end
