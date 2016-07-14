require 'sinatra'
require 'sinatra/reloader'
require 'mysql2'
require_relative 'db_connector'
require_relative 'models/init'

DB = DbConnector.new

get '/' do
  @title = 'main'
  @content = 'main_content'
  @users = []

  users = DB.con.query("SELECT * FROM users")

  users.each do |u|
    @users << User.new(u)
  end

  erb :index
end

get '/new' do
  @title = 'new'
  @content = 'new_content'
  erb :new
end

post '/create' do
  DB.con.query("INSERT INTO users (name, age) VALUES ('#{params['name']}','#{params['age']}')")
  redirect to '/'
end

helpers do
  def link_to(url, txt = url)
    %Q(<a href="#{url}">"#{txt}"</a>)
  end
end

