class List < ApplicationRecord
  belongs_to :user
  has_many :items

  validates :name,
            presence: true

  validates :name,
            uniqueness: true,
            if: :list_exists?

  scope :search_by_name, lambda { |param|
    where("lower(name) like ?", "%#{param.downcase}%") if param
  }

  private

  def list_exists?
    user.lists.any? { |list| list.name == name }
  end
end
