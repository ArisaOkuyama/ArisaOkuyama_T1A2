require "tty-prompt"

class Coffee
    attr_reader :type, :size, :milk, :sugar, :extra
    def initialize(type, size, milk, sugar, extra)
        @type = type
        @size = size
        @milk = milk
        @sugar = sugar
        @extra = extra
    end
end

def customise_coffee
    prompt = TTY::Prompt.new
    coffee_type = prompt.select("Please choose coffee type") do |menu|
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

class Price < Coffee
    attr_reader :indivisual_coffee_price
    def initialize(price)
        @indivisual_coffee_price = price
        # @size = size
        # @milk = type
        # @type = type
    end
end

def pricing_coffee(size,milk)
    coffee_price = 0
    case size
    when "Small"
        coffee_price += 3.5
    when "Medium"
        coffee_price += 4
    when "Large"
        coffee_price += 5
    end

    case milk
    when "Almond Milk"
        coffee_price += 0.5
    when "Soy Milk"
        coffee_price += 0.5
    end

    return Price.new(coffee_price)
end

    def show_menu_option
        prompt = TTY::Prompt.new
        options = prompt.select("MENU") do |menu|
            menu.choice 'ADD' 
            menu.choice 'REMOVE' 
            menu.choice 'PAY'
            menu.choice 'REVIEW'
            menu.choice 'EXIT'
        end
        return options
    end

    def greeting
        puts "Welcome to Coder Coffee"
        puts "First, please type your name"
        name = gets.chomp
        puts "Thank you, #{name}"
        puts 'Would you like to plece an order today?'
    end
greeting()

order_list_array = []
customised_coffee = customise_coffee()
#customised_coffee is an instance of Coffee class
puts "you have chosen a #{customised_coffee.size} #{customised_coffee.type} with #{customised_coffee.milk} and with #{customised_coffee.sugar} (other request: #{customised_coffee.extra})"
order_list_array.push customised_coffee
price_list = 0
# price_list += pricing_coffee(customised_coffee.size,customised_coffee.milk).to_s
price_list += pricing_coffee(customised_coffee.size,customised_coffee.milk).indivisual_coffee_price
exit = false
while exit == false 
    option = show_menu_option()
    case option
    when "ADD"
        customised_coffee = customise_coffee()
        puts "you have chosen a #{customised_coffee.size} #{customised_coffee.type} with #{customised_coffee.milk} and with #{customised_coffee.sugar} (other request: #{customised_coffee.extra})"
        order_list_array.push customised_coffee
        # price_list += pricing_coffee(customised_coffee.size,customised_coffee.milk).to_s
        price_list += pricing_coffee(customised_coffee.size,customised_coffee.milk).indivisual_coffee_price
    when "REVIEW"
        # system 'clear'
        p order_list_array
        puts "YOUR ORDER LIST"
        puts "#{customised_coffee.size} #{customised_coffee.type} with #{customised_coffee.milk}"
        puts "Total bill is $#{price_list} so far"
    when "PAY"
        # system 'clear'
        puts "Thank you for your order"
        puts "It's going to be $#{price_list} for today"
        puts "Thank you"
        exit = true
    when "REMOVE"
        system 'clear'
        p order_list_array
        p price_list
        puts "which number of coffee would like to remove from list?"
        number = gets.chomp
        order_list_array.delete_at(number.to_i)
        system 'clear'
        p order_list_array
        p price_list
    when "EXIT"
        exit = true
    end
end