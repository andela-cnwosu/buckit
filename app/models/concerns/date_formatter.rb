module DateFormatter
  def date_created
    object.created_at.strftime("%Y-%m-%d %I:%M:%S")
  end

  def date_modified
    object.updated_at.strftime("%Y-%m-%d %I:%M:%S")
  end
end
