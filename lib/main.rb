module Main
  def production?
    VR.env == "prod"
  end

  def page_title(item)
    elements = []

    if @item.key?(:breadcrumb)
      @item[:breadcrumb].reverse_each do |b|
        elements << b[:name]
      end
    end
    elements << @item[:name] if @item.key?(:name)
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
