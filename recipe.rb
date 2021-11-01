class Recipe
  attr_accessor :name, :description, :rate, :mark_status, :prep_time, :link

  def initialize(attributes = { name: name, description: description,
                                rate: 0, mark_status: false,
                                prep_time: prep_time, link: link })
    @name = attributes[:name]
    @description = attributes[:description]
    @rate = attributes[:rate]
    @mark_status = attributes[:mark_status]
    @prep_time = attributes[:prep_time]
    @link = attributes[:link]
  end
end
