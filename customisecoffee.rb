# require_relative './coffee'

class CustomiseCoffee
    attr_reader :type, :size, :milk, :sugar, :extra, :name
    
    def download_csv(name, list)
        # To a file
        CSV.open("./file.csv", "w") do |csv|
            csv << [Time.now]
            csv << ["COFFEE ORDER FOR #{name}"]
            csv << [list.map {|coffee| coffee.type}]
            csv << [list.map {|coffee| coffee.size}]
            csv << [list.map {|coffee| coffee.milk}]
            csv << [list.map {|coffee| coffee.sugar}]
            csv << [list.map {|coffee| coffee.extra}]
         end
    end

    def customise_coffee
        prompt = TTY::Prompt.new(symbols: {marker: '⬡'})
        coffee_type = prompt.select("Please choose coffee type") do |menu|
            puts "Use ←/→ arrow keys for more choise"
            menu.choice 'Flat White'
            menu.choice 'Latte'
            menu.choice 'Cappuccino'
            menu.choice 'Long Black'
            menu.choice 'Mocha'
            menu.choice 'Hot Chocolate'
            menu.choice 'Chai Latte'
            menu.choice 'Piccolo'
            menu.choice 'Espresso'
            menu.choice 'Double Espresso'
        end
        case coffee_type
        when 'Flat White', 'Latte','Cappucino', 'Long Black', 'Mocha', 'Chai Latte', 'Hot Chocolate'
            coffee_size = prompt.select("Please choose size of coffee ") do |menu|
            menu.choice 'Small'
            menu.choice 'Medium'
            menu.choice 'Large'
            end
        end
        case coffee_type
        when 'Flat White', 'Latte', 'Cappucino', 'Mocha', 'Chai Latte', 'Piccolo'
            coffee_milk = prompt.select("Please choose type of milk ") do |menu|
            menu.choice 'Full Milk'
            menu.choice 'Skim Milk'
            menu.choice 'Almond Milk +50c '
            menu.choice 'Soy Milk +50c'
            end
        end
        coffee_sugar = prompt.select("Would you like sugar in your coffee?") do |menu|
            menu.choice 'No sugar'
            menu.choice 'half sugar'
            menu.choice '1 sugar'
            menu.choice '2 sugar'
            menu.choice '3 sugar'
            menu.choice '4 sugar'.colorize(:yellow)
            menu.choice '5 sugar. Are you sure?'.colorize(:red)
        end
        coffee_extra = prompt.select("Optinal" ) do |menu|
            puts 'Use ↑/↓ arrow keys, press Space to select and Enter to finish'
            menu.choice 'No thank you'
            menu.choice 'Extra hot'.colorize(:red)
            menu.choice 'half strangh'
            menu.choice 'quoter strangh'
            menu.choice 'decaf'
            menu.choice 'warm'
        end
            # return customised_coffee = [coffee_type,coffee_size,coffee_milk,coffee_sugar,coffee_extra]
            
            return Coffee.new(coffee_type,coffee_size,coffee_milk,coffee_sugar,coffee_extra)
        end
end