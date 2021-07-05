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

  def is_current?(path)
    @item.path == path ||
      @item.path == path + "/"
  end
end

include Nanoc::Helpers::Rendering
include Nanoc::Helpers::ChildParent
include Main
