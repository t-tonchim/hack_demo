require 'sinatra'
require 'sinatra/reloader'
require 'mysql2'
require 'json'
require_relative 'db_connector'
require_relative 'models/init'

set :environment, :production
#set :port, 80

#disable rack protection
disable :protection
enable :sessions

DB = DbConnector.new

get '/' do
  session[:value] ||= rand 100
  @cookie = session[:value]
  @title = 'main'
  @users = []
  users = DB.con.query("SELECT * FROM users")

  users.each do |user|
    @users << User.new(user)
  end

  erb :index
end

post '/users' do
  content_type :json
  result = DB.con.query("SELECT * FROM users WHERE id = #{params[:id]}")
  users = []

  result.each do |r|
    users << r
  end

  output = { "users" => users }
  output.to_json
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

get '/question' do
  erb :question
end

post '/question' do
  session[:name], session[:join], session[:tec], session[:assign] = params['name'], params['joined_day'], params['tec'], params['assign']
  session[:news], session[:person], session[:reason] = params['news'], params['person'], params['reason']
  redirect to '/thank'
end

get '/thank' do
  erb :thank
end

helpers do
  def link_to(url, txt = url)
    %Q(<a href="#{url}">"#{txt}"</a>)
  end
end

