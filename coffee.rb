class Coffee
    attr_reader :type, :size, :milk, :sugar, :extra
        def initialize(type, size, milk, sugar, extra)
            @type = type
            @size = size
            @milk = milk
            @sugar = sugar
            @extra = extra
        end

        def get_price()
            coffee_price = 0
            case @size
            when "Small"
                coffee_price += 3.50
            when "Medium"
                coffee_price += 4.00
            when "Large"
                coffee_price += 5.00
            end
        
            case @milk
            when "Almond Milk", "Soy Milk"
                coffee_price += 0.50
            end
            
            case @type
            when 'Piccolo', 'Double Esppresso'
                coffee_price += 3.00
            when 'Esppresso'
                coffee_price += 2.50
            end
            return coffee_price
        end
end

def customise_coffee
    prompt = TTY::Prompt.new
    coffee_type = prompt.select("Please choose coffee type") do |menu|
        puts "Use ←/→ arrow keys for more choise"
        menu.choice 'Flat White'
        menu.choice 'Latte'
        menu.choice 'Cappucino'
        menu.choice 'Long Black'
        menu.choice 'Mocha'
        menu.choice 'Hot Chocolate'
        menu.choice 'Chai Latte'
        menu.choice 'Piccolo'
        menu.choice 'Esppresso'
        menu.choice 'Double Esppresso'
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
        menu.choice 'Almond Milk'
        menu.choice 'Soy Milk'
        end
    end
    coffee_sugar = prompt.select("Would you like sugar in your coffee?") do |menu|
        menu.choice 'No sugar'
        menu.choice 'half sugar'
        menu.choice '1 sugar'
        menu.choice '2 sugar'
        menu.choice '3 sugar'
        menu.choice '4 sugar'
        menu.choice '5 sugar. Are you sure?'
    end
    coffee_extra = prompt.select("Optinal" ) do |menu|
        puts 'Use ↑/↓ arrow keys, press Space to select and Enter to finish'
        menu.choice 'No thank you'
        menu.choice 'Extra hot'
        menu.choice 'half strangh'
        menu.choice 'quoter strangh'
        menu.choice 'decaf'
        menu.choice 'warm'
    end
    # return customised_coffee = [coffee_type,coffee_size,coffee_milk,coffee_sugar,coffee_extra]
    
    return Coffee.new(coffee_type,coffee_size,coffee_milk,coffee_sugar,coffee_extra)
end