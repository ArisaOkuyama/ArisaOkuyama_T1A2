require "tty-prompt"
require_relative 'coffee.rb'
require_relative 'price.rb'

def show_menu_option
    prompt = TTY::Prompt.new
    options = prompt.select("SELECT MENU") do |menu|
        menu.choice 'ADD ITEM TO LIST' 
        menu.choice 'REMOVE FROM LIST' 
        menu.choice 'CHECK YOUR ORDER'
        menu.choice 'CHECK OUT'
        menu.choice 'EXIT'
    end
    return options
end

def greeting
    puts "Welcome to Coder Coffee"
    puts "First, please type your name"
    name = gets.chomp
    system 'clear'
    puts "Hi, #{name}"
    puts 'Would you like to plece an order today?'
end

def show_order_list(order_list_array)
    for x in 0..(order_list_array.length - 1)
        puts "[#{x+1}].#{order_list_array[x].size} #{order_list_array[x].type} #{order_list_array[x].milk} #{order_list_array[x].sugar} #{order_list_array[x].extra}"
    end 
end

greeting()
order_list_array = []
price_list = []
# customised_coffee is an instance of Coffee class
customised_coffee = customise_coffee()
order_list_array.push customised_coffee
price_list.push pricing_coffee(customised_coffee.size,customised_coffee.milk,customised_coffee.type).indivisual_coffee_price

show_order_list(order_list_array)
exit = false
while exit == false
    option = show_menu_option()
    case option
    when "ADD ITEM TO LIST"
        system 'clear'
        customised_coffee = customise_coffee()
        order_list_array.push customised_coffee
        price_list.push pricing_coffee(customised_coffee.size,customised_coffee.milk,customised_coffee.type).indivisual_coffee_price
    when "CHECK YOUR ORDER"
        system 'clear'
        puts "YOUR ORDER LIST"
        show_order_list(order_list_array)
        puts "Total bill is $#{price_list.inject(:+)} so far"
    when "CHECK OUT"
        system 'clear'
        puts "Thank you for your order"
        puts "It's going to be $#{price_list.inject(:+)} for today"
        exit = true
    when "REMOVE FROM LIST"
        system 'clear'
        puts "YOUR ORDER LIST"
        show_order_list(order_list_array)
        puts "Total bill is $#{price_list.inject(:+)} so far"
        puts "which number of coffee would like to remove from list?"
        number = gets.chomp
        p price_list
        # raise "Not items for the number " if number.to_i > order_list_array.length
        order_list_array.delete_at(number.to_i-1)
        price_list.delete_at(number.to_i-1)
        system 'clear'
        puts price_list.inject(:+)
        puts "NoW, YOUR ORDER LIST"
        show_order_list(order_list_array)
        puts "Now you total bill is #{price_list.inject(:+)}"
    when "EXIT"
        exit = true
    end
end