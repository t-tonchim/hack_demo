require 'sinatra'
require 'sinatra/reloader'
require 'mysql2'

get '/' do
  @title = 'main'
  @content = 'main_content'
  @users = @user || [User.new(1, "user1"), User.new(2, "user2")]
  erb :index
end

get '/new' do
  @title = 'new'
  @content = 'new_content'
  erb :new
end

post '/create' do
  @user = User.new(params[:id], params[:name])
  redirect to '/'
end

helpers do
  def link_to(url, txt = url)
    %Q(<a href="#{url}">"#{txt}"</a>)
  end
end

#models
class User
  attr_accessor :id
  attr_accessor :name

  def initialize(id, name)
    @id = id
    @name = name
  end
end
