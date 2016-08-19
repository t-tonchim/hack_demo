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
$sessions = []

#show index
get '/' do
  unless session[:name]
    redirect to '/question'
  end

  session[:value] ||= rand 100
  @cookie = session
  @title = 'main'
  @users = []
  users = DB.con.query("SELECT * FROM users")

  users.each do |user|
    @users << User.new(user)
  end

  unless $sessions.any? { |s| s[:session_id] == session[:session_id] }
    $sessions << session
  end

  erb :index
end

#return users json data
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

#show user create form
get '/new' do
  @title = 'new'
  @content = 'new_content'
  erb :new
end

#user create
post '/create' do
  DB.con.query("INSERT INTO users (name, age) VALUES ('#{params['name']}','#{params['age']}')")
  redirect to '/'
end

#show question form
get '/question' do
  erb :question
end

#create session by question
post '/question' do
  session[:name], session[:join], session[:tec], session[:assign] = params['name'], params['joined_day'], params['tec'], params['assign']
  session[:news], session[:person], session[:reason] = params['news'], params['person'], params['reason']
  session[:cookie] = env['HTTP_COOKIE']
  unless $sessions.any? { |s| s[:session_id] == session[:session_id] }
    $sessions << session
  end

  redirect to '/thank'
end

get '/thank' do
  erb :thank
end

get '/sessions' do
  @sessions = $sessions
  erb :sessions
end

#helper for views
helpers do
  def link_to(url, txt = url)
    %Q(<a href="#{url}">#{txt}</a>)
  end
end

