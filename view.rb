class View
  def display(all_recipes)
    puts '=========================='
    puts 'List of all recipes:'
    all_recipes.each_with_index do |r, index|
      puts "#{index + 1}. [#{r.mark_status ? 'X' : ' '}]  #{r.name}. Prep time: #{r.prep_time} - (#{r.rate} / 5)"
    end
    puts '=========================='
  end

  def ask_for_recipe_name?
    puts 'What recipe name?'
    gets.chomp
  end

  def ask_for_recipe_description?
    puts 'What is the recipe description?'
    gets.chomp
  end

  def ask_for_prep_time?
    puts 'How long is the prep time?'
    gets.chomp
  end

  def ask_for_recipe_index_to_delete?
    puts 'Which recipe number do you want to delete?'
    gets.chomp.to_i
  end

  def ask_for_keyword_to_search?
    puts 'What ingredient would you like a recipe for?'
    gets.chomp
  end

  def ask_which_to_save?(lists)
    puts '=============================='
    puts 'List of recipes to save:'
    lists.each_with_index { |a, index| puts "#{index + 1}. #{a.name} - #{a.description} - (#{a.rate} / 5) - #{a.prep_time}" }
    puts '=============================='
    puts 'What recipe would you like to save?'
    choice = nil
    until (0..(lists.count - 1)).to_a.include?(choice)
      choice = gets.chomp.to_i - 1
      puts 'No such recipes in list.' unless (0..lists.count - 1).to_a.include?(choice)
    end
    choice
  end

  def ask_for_which_index?
    puts 'Which recipe?'
    gets.chomp.to_i - 1
  end

  def ask_rating?
    puts 'What rating?'
    gets.chomp.to_i
  end
end
