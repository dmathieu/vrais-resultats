$LOAD_PATH.unshift File.expand_path("app", __dir__)
require "vr"
require "ostruct"

module Rails
  def self.root
    File.dirname(__FILE__)
  end

  def self.env
    VR.database_env
  end

  def self.application
    OpenStruct.new(
      config: OpenStruct.new(
        load_database_yaml: {}
      )
    )
  end
end

ActiveRecord::Tasks::DatabaseTasks.env = VR.database_env
ActiveRecord::Tasks::DatabaseTasks.db_dir = File.expand_path("../db", __FILE__)
ActiveRecord::Tasks::DatabaseTasks.database_configuration = ActiveRecord::Base.configurations
ActiveRecord::Tasks::DatabaseTasks.migrations_paths = [File.join(ActiveRecord::Tasks::DatabaseTasks.db_dir, "migrate")]

task :environment do
end

load "active_record/railties/databases.rake"
