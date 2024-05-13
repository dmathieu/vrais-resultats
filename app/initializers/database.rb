# frozen_string_literal: true

require 'active_record'

ActiveRecord::Base.configurations = YAML.safe_load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(VR.database_env.to_sym)
