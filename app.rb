require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'cookbook'
require_relative 'scrape_service'
set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file = File.join(__dir__, 'recipes.csv')
cookbook = CookBook.new(csv_file)
scrape = []

get '/' do
  @all_recipes = cookbook.all
  erb :index
end

get '/views/act_add_new_recipe' do
  # @all_recipes = cookbook.all
  erb :act_add_new_recipe
end

get '/views/act_add_new_recipe_success' do
  recipe = Recipe.new({name: params["name"],
                       description: params["description"],
                       prep_time: params["prep_time"]})
  cookbook.add_recipe(recipe)
  erb :act_add_new_recipe_success
end

get '/about' do
  erb :about
end

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end

get "/delete/:index" do
  cookbook.remove_recipe(params[:index].to_i)
  redirect '/'
end

get "/mark_as_read/:index" do
  cookbook.mark(params[:index].to_i)
  redirect '/'
end

get '/views/import_new_recipes' do
  erb :import_new_recipes
end

get '/views/listing' do
  @scrape = ScrapeAllrecipesService.new(params["keyword"]).call
  scrape = @scrape
  erb :listing
end

get "/import_this_one/:index" do
  # binding.pry
  cookbook.add_recipe(scrape[params[:index].to_i])
  redirect '/'
end
