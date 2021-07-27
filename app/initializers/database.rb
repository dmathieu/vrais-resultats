require "active_record"

ActiveRecord::Base.configurations = YAML.safe_load(File.open("config/database.yml"))
ActiveRecord::Base.establish_connection(:production)
