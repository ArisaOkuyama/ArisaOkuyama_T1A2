require "tty-prompt"
class CreateItem
    def initialize
    end

    def customise_coffee
        prompt = TTY::Prompt.new
        coffee_type = prompt.select("Please choose coffee type") do |menu|
            menu.choice 'Flat White'
            menu.choice 'Latte'
            menu.choice 'Cappucino'
            menu.choice 'Long Black'
            menu.choice 'Mocha'
            menu.choice 'Hot chocolate'
            menu.choice 'Chai Latte'
        end
        coffee_size = prompt.select("Please choose size of coffee ") do |menu|
            menu.choice 'Small'
            menu.choice 'Medium'
            menu.choice 'Large'
        end
        coffee_milk = prompt.select("Please choose type of milk ") do |menu|
            menu.choice 'Full Milk'
            menu.choice 'Skim Milk'
            menu.choice 'Almond Milk'
            menu.choice 'Soy Milk'
            menu.choice 'No milk'
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
        coffee_extra = prompt.multi_select("Optinal" ) do |menu|
            puts 'Use ↑/↓ arrow keys, press Space to select and Enter to finish'
            menu.choice 'No thank you'
            menu.choice 'Extra hot'
            menu.choice 'half strangh'
            menu.choice 'quoter strangh'
            menu.choice 'decaf'
            menu.choice 'warm'
        end
        system("clear")
        return customised_coffee = [coffee_type,coffee_size,coffee_milk,coffee_sugar,coffee_extra]
    end
    def pricing_coffee(a,b)
        price_for_coffee = 0
        case a
        when "Small"
        price_for_coffee += 3.5
        when "Medium"
        price_for_coffee += 4
        when "Large"
        price_for_coffee += 5
        end

        case b
        when "Almondmilk"
        price_for_coffee += 0.5
        when "Soymilk"
        price_for_coffee += 0.5
        end
        return price_for_coffee
    end

    def show_menu_option
        prompt = TTY::Prompt.new
        options = prompt.select("MENU" ) do |menu|
            menu.choice 'ADD' 
            menu.choice 'REMOVE' 
            menu.choice 'PAY'
            menu.choice 'REVIEW'
        end
        return options
    end
    def greeting
        puts "Welcome to Coder Coffee"
        puts 'Would you like to plece an order?'
    end
end


coffee_user1 = CreateItem.new()

coffee_user1.greeting()
order_list_array = []
while true
    customised_coffee = coffee_user1.customise_coffee
    puts "you have chosen a #{customised_coffee[1]} #{customised_coffee[0]} with #{customised_coffee[2]} and with #{customised_coffee[3]} (other request: #{customised_coffee[4]})"
    order_list_array.push 
    puts order_list_array
    # price_list = coffee_user1.pricing_coffee(customised_coffee[1],customised_coffee[2])
    
    option = coffee_user1.show_menu_option()

    if option == "ADD"
        customised_coffee = coffee_user1.customise_coffee
    elsif option == "REVIEW"
        puts 
    elsif option == "PAY"
        return false
    else
        return false
    end
end