require "active_support"
require "active_support/core_ext"

module VR
  def self.env
    ENV["VR_ENV"] || "prod"
  end
end

require "dataset"
require "fetcher"
require "mapper"
require "reducer"
