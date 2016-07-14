require 'yaml'

class DbConnector
  attr_reader :klass
  attr_reader :host
  attr_reader :user
  attr_reader :pass
  attr_reader :db
  attr_reader :con
  yml = YAML.load_file('db_info.yml')
  PROF = yml['database']

  def initialize
    @host = PROF['host']
    @user = PROF['username']
    @pass = PROF['password']
    @db   = PROF['database']
    @con  = Mysql2::Client.new(host: @host, username: @user, password: @pass, database: @db)
  end
end
