class Item < ApplicationRecord
  belongs_to :list

  validates :name, presence: true

  scope :search_by_name, lambda { |param|
    where("lower(name) like ?", "%#{param.downcase}%") if param
  }
end
