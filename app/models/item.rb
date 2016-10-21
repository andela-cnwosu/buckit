class Item < ApplicationRecord
  belongs_to :list

  validates :name, presence: true
  validates :done, presence: true
end
