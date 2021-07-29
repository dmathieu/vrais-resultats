module Main
  def production?
    VR.env == "prod"
  end

  def page_title(item)
    elements = []

    elements << @item[:name] if @item.key?(:name)
    elements << @item[:election] if @item.key?(:election)
    elements << "Vrais Résultats"
    elements.join(" - ")
  end

  def page_description(item)
    if item.key?(:election)
      return "Résultats de l'élection #{item[:election]} pour #{item[:name]}"
    end
    if item.key?(:name)
      return "Résultats des élections #{item[:name]}"
    end

    "Vrais résultats des élections Fran&ccedil;aises"
  end

  def is_current?(path)
    @item.path == path ||
      @item.path == path + "/"
  end
end

include Nanoc::Helpers::Blogging
include Nanoc::Helpers::Breadcrumbs
include Nanoc::Helpers::Rendering
include Nanoc::Helpers::ChildParent
include Nanoc::Helpers::XMLSitemap
include Main
