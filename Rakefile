$LOAD_PATH.unshift File.expand_path("app", __dir__)
require "vr"

module Rails
  def self.root
    File.dirname(__FILE__)
  end

  def self.env
    "production"
  end
end

ActiveRecord::Tasks::DatabaseTasks.env = "production"
ActiveRecord::Tasks::DatabaseTasks.db_dir = File.expand_path("../db", __FILE__)
ActiveRecord::Tasks::DatabaseTasks.database_configuration = ActiveRecord::Base.configurations
ActiveRecord::Tasks::DatabaseTasks.migrations_paths = [File.join(DatabaseTasks.db_dir, "migrate")]

task :environment do
end

load "active_record/railties/databases.rake"
