$LOAD_PATH.unshift File.expand_path("../app", __dir__)
require "vr"

module Generation
  def dataset
    @dataset ||= VR::Dataset.new("datasets/")
  end

  def auto_generate_pages
    content = File.read(File.expand_path("layouts/templates/election.erb"))
    dataset.each do |election|
      data = election[:data]
      data = data.take(5) if VR.env == "dev"

      data.each do |v|
        bread = []
        v[:path].split("/").each do |b|
          bread << b
          unless bread.join("/") == v[:path]
            create_list_page(
              @items,
              {
                election: election[:name],
                name: bread.last.capitalize,
                path: bread.join("/")
              }
            )
          end
        end
        v[:election] = election[:name]

        path = "/" + election[:name].parameterize
        path << "/" + v[:path] unless v[:path].blank?
        path << ".erb"

        @items.create(content, v, path)
      end
    end
  end

  def create_list_page(items, info)
    path = "/#{info[:election].parameterize}/#{info[:path]}.erb"
    return unless items[path].nil?
    content = File.read(File.expand_path("layouts/templates/list.erb"))
    items.create(content, info, path)
  end
end

include Generation
