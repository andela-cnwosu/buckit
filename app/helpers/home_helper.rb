module HomeHelper
  def link_by_signed_in
    if signed_in?
      "/documentation"
    else
      "/"
    end
  end
end
