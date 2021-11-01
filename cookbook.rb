require_relative 'recipe'
require 'csv'
require 'pry-byebug'
require 'open-uri'
require 'nokogiri'

class CookBook
  attr_reader :recipe_arr_add, :recipes

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    @csv_array = []
    # @recipe_arr_add = []
    @rec_index_del = nil
    parse_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    # @recipe_arr_add << recipe
    @recipes << recipe
    update_csv
  end

  def remove_recipe(recipe_index)
    # @rec_index_del = recipe_index - 1
    @recipes.delete_at(recipe_index)
    update_csv
  end

  def rate_recipe(index, rate)
    @recipes[index].rate = rate
    update_csv
  end

  def mark(index)
    @recipes[index].mark_status = !@recipes[index].mark_status
    update_csv
  end

  # def add_prep_time(link)
  #   doc = Nokogiri::HTML(File.open('strawberry_delight.html').read) # to test
  #   doc.css('.recipe-meta-item-body').first.text.strip
  # end

  private

  # get all the info from csv file and push to csv_array
  def parse_csv
    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new({ name: row[0],
                               description: row[1],
                               rate: row[2],
                               mark_status: (row[3] == 'true'),
                               prep_time: row[4] })
    end
  end

  def update_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    # remove any item from csv_array if remove_recipe is used
    # @csv_array.delete_at(@rec_index_del) unless @rec_index_del.nil?
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      # binding.pry
      # @recipe_arr_add.each { |recipe| @csv_array << recipe }
      @recipes.each { |row| csv << [row.name, row.description, row.rate, row.mark_status, row.prep_time] }
      # add in new recipe to the csv file
    end
  end
end
