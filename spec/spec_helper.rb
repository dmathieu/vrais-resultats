$LOAD_PATH.unshift File.expand_path("../app", __dir__)
require "vr"

require "webmock/rspec"
WebMock.disable_net_connect!

ENV["VR_DATABASE_ENV"] = "test"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.around :each do |s|
    Dir.mktmpdir do |dir|
      VR::Fetcher.set_path_dir(dir)
      VR::Dataset.set_path_dir(dir)
      FileUtils.mkdir_p File.join(dir, "cache/fetcher")
      FileUtils.mkdir_p File.join(dir, "cache/dataset")
      s.run
      VR::Fetcher.set_path_dir("")
      VR::Dataset.set_path_dir("")
    end
  end

  def file_fixture(name)
    File.open(File.expand_path("spec/fixtures/" + name)).read
  end
end
