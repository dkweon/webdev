# app.rb
# this is a simple Sinatra example app

# use bundler
require 'rubygems'
require 'bundler/setup'
# load all of the gems in the gemfile
Bundler.require

# define a route for the root of the site
get '/' do
  # render the views/index.erb template

#	line = File.read("todo.txt").split("\n")
#	@task = line.split("-")
#	@task = []

#	if :date

	#split line into task, -, and date
	#if date is empty,
	#	then just display task
	#	otherwise display both task and date.
#	erb :index
#end

#	unless File.readlines('todo.txt') == lines
#  puts "readlines works, too - but it keeps newlines so it's a bit different!"

	erb :index
end




post '/' do
 File.open("todo.txt", "a") do |file|
    file.puts "#{params[:task]} - #{params[:date]}"
		@task = [:task, :date]
  end
	redirect "/"
end
