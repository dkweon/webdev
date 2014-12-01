# app.rb
# this is a simple Sinatra example app

# use bundler
require 'rubygems'
require 'bundler/setup'
# load all of the gems in the gemfile
Bundler.require

require './models/TodoItem'
require './models/Users'

if ENV['DATABASE_URL']
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
  ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'db/development.db',
  :encoding => 'utf8'
  )
end



# define a route for the root of the site

#user
get '/' do
  @user = Users.all.order(:name)
  erb :user_list
end

post '/' do
  Users.create(name: params[:name])
  redirect '/'
end

#todo list

get '/:name' do
  @user = Users.find(params[:name])
  @tasks = @user.todo_items.order(:due)
  erb :todo_list
end

post '/:name' do
  userID = Users.findby(name: params[:name]).id
  TodoItem.create(description: params[:task], due: params[:date])
  redirect "/#{params[:name]}"
end

#deleting user and list "items"
get '/:name/delete' do
  Users.find_by(name: params[:name]).destroy
  redirect '/'
end


get '/:name/delete/:id' do
  TodoItem.find_by(id: params[:id]).destroy
  redirect "/#{params[:name]}"
end
