$LOAD_PATH.unshift File.expand_path("../app", __dir__)
require "vr"

module Generation
  def dataset
    @dataset ||= VR::Dataset.new("datasets.json")
  end

  def auto_generate_pages
    content = File.read(File.expand_path("layouts/templates/election.erb"))
    dataset.each do |election|
      data = election[:data]
      data = data.take(5) if VR.env == "dev"

      data.each do |v|
        bread = []
        v[:breadcrumb].each do |b|
          bread << b
          unless b[:current]
            create_breadcrumb_page(
              @items,
              b.merge(election: election[:name], breadcrumb: bread.dup)
            )
          end
        end
        path = v[:breadcrumb].last[:path]
        v[:election] = election[:name]
        @items.create(content, v, "#{path}.erb")
      end
    end
  end

  def create_breadcrumb_page(items, info)
    return if info[:type].nil?
    return unless items["#{info[:path]}.erb"].nil?
    content = File.read(File.expand_path("layouts/templates/#{info[:type]}.erb"))
    items.create(content, info, "#{info[:path]}.erb")
  end
end

include Generation
