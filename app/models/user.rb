class User < ApplicationRecord
  has_secure_password

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,
            presence: true,
            uniqueness: true,
            format: EMAIL_REGEX

  validates :password,
            presence: true,
            confirmation: true,
            length: { minimum: 6 }
end
