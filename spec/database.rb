require 'yaml'

class Database
  TEST_ROOT = File.expand_path(File.dirname(__FILE__))
  DATABASE_CONFIG = "#{TEST_ROOT}/config.yml"

  def self.config
    data = File.open(DATABASE_CONFIG).read
    YAML.parse(data).transform
  end
end