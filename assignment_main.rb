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
    end
end

def pricing_coffee(size,milk,type)
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
    when "Almond Milk", "Soy Milk"
        coffee_price += 0.5
    end
    
    case type
    when 'Piccolo', 'Double Esppresso'
        coffee_price += 3
    when 'Esppresso'
        coffee_price += 2.5
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

class OrderList < Price
    attr_reader :order_list_array
    def initialize
        @order_list_array = []
    end
    def  show_order_list
        for x in 0..(order_list_array.length - 1)
            puts "[#{x+1}].#{order_list_array[x].size} #{order_list_array[x].type} with #{order_list_array[x].milk}"
        end 
    end
end

def greeting
    puts "Welcome to Coder Coffee"
    puts "First, please type your name"
    name = gets.chomp
    system 'clear'
    puts "Hi, #{name}"
    puts 'Would you like to plece an order today?'
end

greeting()
customised_coffee = customise_coffee()
#customised_coffee is an instance of Coffee class
puts "you have chosen a #{customised_coffee.size} #{customised_coffee.type} with #{customised_coffee.milk} and with #{customised_coffee.sugar} (other request: #{customised_coffee.extra})"
order_list_array = []
order_list_array.push customised_coffee
price_list = []
# price_list += pricing_coffee(customised_coffee.size,customised_coffee.milk).to_s
price_list.push pricing_coffee(customised_coffee.size,customised_coffee.milk,customised_coffee.type).indivisual_coffee_price
exit = false
while exit == false 
    option = show_menu_option()
    case option
    when "ADD"
        customised_coffee = customise_coffee()
        puts "you have chosen a #{customised_coffee.size} #{customised_coffee.type} with #{customised_coffee.milk} and with #{customised_coffee.sugar} (other request: #{customised_coffee.extra})"
        order_list_array.push customised_coffee
        # price_list += pricing_coffee(customised_coffee.size,customised_coffee.milk).to_s
        price_list.push pricing_coffee(customised_coffee.size,customised_coffee.milk,customised_coffee.type).indivisual_coffee_price
    when "REVIEW"
        system 'clear'
        puts "YOUR ORDER LIST"
        for x in 0..(order_list_array.length - 1)
        puts "[#{x+1}].#{order_list_array[x].size} #{order_list_array[x].type} with #{order_list_array[x].milk}"
        end
        puts "Total bill is $#{price_list.inject(:+)} so far"
    when "PAY"
        system 'clear'
        puts "Thank you for your order"
        puts "It's going to be $#{price_list.inject(:+)} for today"
        exit = true
    when "REMOVE"
        system 'clear'
        p order_list_array
        puts "YOUR ORDER LIST"
        for x in 0..(order_list_array.length - 1)
        puts "[#{x+1}].#{order_list_array[x].size} #{order_list_array[x].type} with #{order_list_array[x].milk}"
        end
        puts "Total bill is $#{price_list.inject(:+)} so far"
        puts "which number of coffee would like to remove from list?"
        number = gets.chomp
        p price_list
        order_list_array.delete_at(number.to_i-1)
        price_list.delete_at(number.to_i-1)
        system 'clear'
        puts price_list.inject(:+)
        puts "NoW, YOUR ORDER LIST"
        for x in 0..(order_list_array.length - 1)
        puts "[#{x+1}].#{order_list_array[x].size} #{order_list_array[x].type} with #{order_list_array[x].milk}"
        end

        puts "Now you total bill is #{price_list.inject(:+)}"
    when "EXIT"
        exit = true
    end
end