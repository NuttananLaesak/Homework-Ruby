class Recipe < ApplicationRecord
  belongs_to :catagory

  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  def self.import(file)
    xlsx = Roo::Excelx.new(file.tempfile)

    xlsx.each_row_streaming(offset: 1) do |r|
      recipe = self.new(name: r[0].value, description: r[1].value, instruction: r[2].value, catagory_id: r[3].value)

      puts "===================="
      puts r[0].inspect, r[1].inspect, r[2].inspect, r[3].inspect
      puts "===================="

      recipe.save
    end

  end
end
