class List < ApplicationRecord
  belongs_to :user
  has_many :items

  validates :name,
            presence: true

  validates :name,
            uniqueness: true,
            if: :list_exists?

  SETTINGS = {
    page_limit: 100,
    default_page_limit: 20,
    min_page_limit: 1
  }.freeze

  def self.paginate(page, limit)
    page = (page.to_i if page) || 1
    limit = (limit.to_i if limit) || SETTINGS[:default_page_limit]
    offset = (page - 1) * limit
    order(id: "asc").offset(offset).limit(limit)
  end

  def self.search_by_name(param)
    where(name: param)
  end

  private

  def list_exists?
    user.lists.any? { |list| list.name == name }
  end
end
