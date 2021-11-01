require 'pry-byebug'
require 'open-uri'
require 'nokogiri'
require_relative 'recipe'


class ScrapeAllrecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # Ask a user for a keyword to search
    # Make an HTTP request to the recipe’s website with our keyword
    url = "https://www.allrecipes.com/search/results/?search=#{@keyword}"
    doc = Nokogiri::HTML(URI.open(url).read)
    # doc = Nokogiri::HTML(File.open('strawberry.html').read) # to test
    import = []
    # Parse the HTML document to extract the first 5 recipes suggested and store them in an Array
    5.times do |a|
      import << Recipe.new({ name: doc.css('h3.card__title')[a].text.strip,
                             description: doc.css('.card__summary')[a].text.strip,
                             mark_status: false,
                             link: doc.css('.card__detailsContainer .card__titleLink[href]')[a]["href"] })
    end

    5.times do |a|
      recipe_doc = Nokogiri::HTML(URI.open(import[a].link).read)
      import[a].rate = recipe_doc.css('.review-star-text')[0].text.scan(/\d.\d*/)[0].to_f
      import[a].prep_time = recipe_doc.css('.recipe-meta-item-body').first.text.strip
    end
    import
  end
end
