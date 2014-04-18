require File.expand_path(File.dirname(__FILE__)) + '/../spec/database'

namespace :db do
  desc 'Build MySQL and PostgreSQL test databases'
  task create: ['mysql:build_databases', 'postgresql:build_databases']
  desc 'Drop MySQL and PostgreSQL test databases'
  task drop: ['mysql:drop_databases', 'postgresql:drop_databases']
end

namespace :mysql do
  config = Database.config['mysql2']

  desc 'Build the MySQL test databases'
  task :build_databases do
    %x( mysql --user=#{config['username']} -e "create DATABASE #{config['database']} DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_unicode_ci ")
  end

  desc 'Drop the MySQL test databases'
  task :drop_databases do
    %x( mysqladmin --user=#{config['username']} -f drop #{config['database']} )
  end

  desc 'Rebuild the MySQL test databases'
  task :rebuild_databases => [:drop_databases, :build_databases]
end

namespace :postgresql do
  config = Database.config['postgresql']

  desc 'Build the PostgreSQL test databases'
  task :build_databases do
    %x( createdb -E UTF8 -T template0 #{config['database']} )
  end

  desc 'Drop the PostgreSQL test databases'
  task :drop_databases do
    %x( dropdb #{config['database']} )
  end

  desc 'Rebuild the PostgreSQL test databases'
  task :rebuild_databases => [:drop_databases, :build_databases]
end