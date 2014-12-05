# app.rb
# this is a simple Sinatra example app

# use bundler
require 'rubygems'
require 'bundler/setup'
# load all of the gems in the gemfile
Bundler.require

require './models/TodoItem'
require './models/User'

if ENV['DATABASE_URL']
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
  ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'db/development.db',
  :encoding => 'utf8'
  )
end

enable :sessions
set :session_secret, '85txrIIvTDe0AWPCvbeXuXXpULCWZgpoRo1LqY8YsR9GAbph0jfOHosvtY4QFxi6'

before do
  @user = User.find_by(name: session[:name])
end

get '/' do
  if @user
    @tasks = @user.todo_items.order(:due)
    erb :index
  else
    erb :login
  end
end

post '/login' do
  user = User.find_by(name: params[:name])
  if user.nil?
    @message = "User not found."
    erb :message
  elsif user.authenticate(params[:password])
    session[:name] = user.name
    redirect '/'
  else

    @message = "Incorrect password."
    erb :message
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

post '/new_user' do
  @user = User.create(params)
  if @user.valid?
    session[:name] = @user.name
    redirect '/'
  else
    @message = @user.errors.full_messages.join(', ')
    erb :message
  end
end

post '/new_item' do
  @user.todo_items.create(description: params[:task], due: params[:date])
  redirect "/"
end
get '/delete_user' do
  @user.destroy
  redirect '/'
end

get '/delete_item/:item' do
  @todo_item = TodoItem.find(params[:item])
  @user = @todo_item.user
  @todo_item.destroy
  redirect "/"
end
