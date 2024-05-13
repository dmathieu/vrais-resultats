# frozen_string_literal: true

module Main
  def production?
    VR.env == 'prod'
  end

  def page_title(_item)
    return @item[:title] unless @item[:title].blank?

    elements = []

    elements << @item[:name] unless @item[:name].blank?
    elements << @item[:election] unless @item[:election].blank?
    elements << 'Vrais Résultats'
    elements.join(' - ')
  end

  def page_description(item)
    unless item[:election].blank?
      c = "Résultats des élections #{item[:election]}"
      c += " pour #{item[:name]}" unless item[:name].blank?

      return c
    end

    'Vrais résultats des élections Fran&ccedil;aises'
  end

  def is_current?(path)
    @item.path == path ||
      @item.path == "#{path}/"
  end
end

include Nanoc::Helpers::Blogging
include Nanoc::Helpers::Breadcrumbs
include Nanoc::Helpers::Rendering
include Nanoc::Helpers::ChildParent
include Nanoc::Helpers::XMLSitemap
include Main
