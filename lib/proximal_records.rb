require "proximal_records/version"

require 'active_support/core_ext/string'

require 'proximal_records/adapters/mysql2'
require 'proximal_records/adapters/postgresql'

module ProximalRecords
  def self.included(base)
    raise 'Should be included to the ActiveRecord::Base class' if base.is_a?(ActiveRecord::Base)

    adapter_class_name = base.connection.adapter_name.downcase.capitalize
    module_path = "ProximalRecords::Adapters::#{adapter_class_name}"
    mod = module_path.constantize

    base.send(:include, mod)
  end
end
