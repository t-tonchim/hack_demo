require 'sinatra'
require 'sinatra/reloader'
require 'mysql2'
require 'json'
require_relative 'db_connector'
require_relative 'models/init'

#disable rack protection
disable :protection

DB = DbConnector.new

get '/' do
  @title = 'main'
  @users = []
  users = DB.con.query("SELECT * FROM users")

  users.each do |user|
    @users << User.new(user)
  end

  erb :index
end

get '/users/:id' do
  content_type :json
  result = DB.con.query("SELECT * FROM users WHERE id = #{params[:id]}")
  users = []

  result.each do |r|
    users << r
  end

  output = { users: users }
  output
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

