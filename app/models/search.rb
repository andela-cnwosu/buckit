class Search
  SETTINGS = {
    page_limit: 100,
    default_page_limit: 20,
    min_page_limit: 1
  }.freeze

  def self.paginate(model, page, limit)
    page = (page.to_i if page) || 1
    limit = (limit.to_i if limit) || SETTINGS[:default_page_limit]
    offset = (page - 1) * limit
    model.order(id: "asc").offset(offset).limit(limit)
  end

  def self.valid_page_limit?(limit)
    valid_limit = (SETTINGS[:min_page_limit]..SETTINGS[:page_limit]).to_a
    valid_limit.include?(limit.to_i) || limit.nil?
  end
end
