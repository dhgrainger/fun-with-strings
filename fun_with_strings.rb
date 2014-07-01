# lets see if i can take an ingredients string and break it into an ingredient, a unit, and an amount

require 'pry'

array = [
"1 1⁄2 teaspoons kosher salt",
"1 pound pasta",
"2 tablespoons olive oil",
"1 small onion, diced",
"3 garlic cloves, minced",
"1 bell pepper, stemmed, seeded, and diced",
"1 large carrot, peeled and diced",
"1 pound lean ground pork",
"One 28-ounce can crushed tomatoes",
"1 1⁄2 tablespoons balsamic vinegar",
"1 teaspoon sugar"]

ingredients = [
"salt",
"pasta",
"olive oil",
"onion",
"cloves",
"bell pepper",
"carrot",
"ground pork",
"tomato",
"balsamic vinegar",
"sugar"]

array2 = ["4 center cut boneless pork chops, pounded to 3/4 inch thick",
   "1 tsp. Vege-sal or slightly less than 1 tsp. salt",
   "fresh ground black pepper",
   "1 tsp. Penzeys Pork Chop Seasoning (optional, contains salt, hickory smoke, gar",
   "2 T olive oil",
   "2/3 cup balsamic vinegar",
   "2 tsp. sugar"]

ingredient2 =["pork",
  "salt",
  "pepper",
  "Seasoning",
  "olive oil",
  "balsamic vinegar",
  "sugar"
  ]

class Ingredients
  attr_accessor :ingredients, :array, :items

  def initialize(array, ingredients)
    @ingredients = ingredients
    @array = array
    @items = []
  end

  def unit(words)
    correct_word = ""
    possible_units = ["tablespoon", "ounce", "teaspoon", "pound", "gram", "oz", "cup", "tsp.", "gal.", "gallon", "T.", "t.", "tbsp."]
    words.each do |word|
      possible_units.each do |unit|
        if word.include?(unit) || unit.include?(word)
          correct_word = unit
        end
      end
    end
    correct_word
  end

  def product(words)
    value = ""
    words.each do |word|
      @ingredients.each do |ingred|
        if word.include?(ingred) || ingred.include?(word)
          value = ingred
        end
      end
    end
    value
  end

  def clean(description, item)
    description.each do |word|
      item.split(' ').each do |item|
        description.delete(word) if word = item
      end
    end
    description.join(' ')
  end

  def description(string)
    binding.pry if string.include?('pepper')
    descr = []
    string.each do |word|
      if word.to_f == 0 && !word.include?(unit(string)) && !word.include?(product(string))
        descr << word
      end
    end
    binding.pry if string.include?('pepper')
    if descr.join(' ').include?(product(string))
      clean(descr, product(string))
    else
      descr = descr.join(' ')
    end
    binding.pry if string.include?('pepper')
    descr
  end

  def quantity(amount)
    if amount.length == 1 && amount[0].split('').length == 1
      return amount[0].to_f
    end

    total = []
    amount.each do |num|
      number = num.split('')
      if number.length == 1
        total << number[0].to_f
      #for some reason the character in 1/2 is not a backslash but something that looks like a backslash
      elsif number.include?('⁄') && number.length == 3 || number.include?('/') && number.length == 3
        number[1] = '/'
        total << Rational(number.join).to_f
      elsif number.length > 1
        bin = []
        number.each do |numb|
          if numb.to_f != 0
            bin << numb
          end
        end
        total << bin.join.to_f
      end
    end
    total = total.inject(:+)
    total
  end

  def compare(string)
    amount = []
    (0..string.length/2).each do |x|
      amount << string[x] if string[x].to_f != 0
    end
    @items << IngredientLine.new(quantity(amount), unit(string), product(string), description(string))
  end

  def convert
    @array.each do |ingredient|
      compare(ingredient.split(' '))
    end
  end
end

class IngredientLine
  attr_accessor :a, :u, :i, :d
  def initialize(a, u, i, d)
    @amount = a
    @unit = u
    @ingredient = i
    @description = d
  end
end

i = Ingredients.new(array2, ingredient2)
i.convert
binding.pry
