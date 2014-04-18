require 'rspec'
require 'active_record'
require 'proximal_records'
require 'database'

# ActiveRecord::Base.logger = Logger.new('test.log')
# ActiveRecord::Base.logger = nil



ActiveRecord::Base.establish_connection(Database.config[ENV['DATABASE'] || 'mysql2'])

# def setup_db
  ActiveRecord::Migration.verbose = false
  load 'schema.rb'
# end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end