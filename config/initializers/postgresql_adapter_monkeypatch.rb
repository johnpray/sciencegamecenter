# Prevent crashing on newer PostgreSQL versions
# with 'invalid value for parameter "client_min_messages": "panic"'.
# https://stackoverflow.com/a/59331868/560089
require 'active_record/connection_adapters/postgresql_adapter'

class ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
  def set_standard_conforming_strings
    old, self.client_min_messages = client_min_messages, 'warning'
    execute('SET standard_conforming_strings = on', 'SCHEMA') rescue nil
  ensure
    self.client_min_messages = old
  end
end
