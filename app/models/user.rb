class User < ApplicationRecord
  has_secure_password
  has_many :lists
  has_many :items, through: :lists
  has_many :oauth_applications,
           class_name: "Doorkeeper::Application",
           as: :owner

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

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def downcase_email
    email.downcase!
  end
end
