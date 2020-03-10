require "tty-prompt"

def customise_coffee
    prompt = TTY::Prompt.new
    puts "What kind of coffee would you like?"
    coffee_type = prompt.select("Please choose coffee type", %w(FlatWhite Latte Capccino))
    coffee_size = prompt.select("What size of coffee would you like?", %w(Small Medium Large))
    coffee_milk = prompt.select("What kind of milk would you like?", %w(Full_milk Skim_milk Almondmilk Soymilk))
    coffee_sugar = prompt.select("Would you like sugar in your coffee?", %w(NoSugar halfSugar 1sugar 2sugar 3sugar 4sugar 5sugar ++))

    return customised_coffee = [coffee_type,coffee_size,coffee_milk,coffee_sugar]
end

# def customise_coffee_size
#     prompt = TTY::Prompt.new
    
#     return coffee_size
# end

customised_coffee = customise_coffee
puts "you have chosen a #{customised_coffee[1]} #{customised_coffee[0]} with #{customised_coffee[2]} and with #{customised_coffee[3]}"
