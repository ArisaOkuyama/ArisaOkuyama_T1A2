require "tty-prompt"
require "tty-font"
require "csv"
require "tty-box"
require 'colorize'
require_relative './coffee'
require_relative './name'
require_relative './customisecoffee'

def show_menu
    prompt = TTY::Prompt.new
    prompt.select("Please select one of the options") do |menu|
        menu.choice 'Add another item to order' 
        menu.choice 'Change/remove item from order' 
        menu.choice 'View order'
        menu.choice 'Check out'
        menu.choice "Exit".colorize(:yellow)
    end
end

def show_order_list(order_list)
    for x in 0..(order_list.length - 1)
        p "[#{x+1}].#{order_list[x].size} #{order_list[x].type} #{order_list[x].milk} #{order_list[x].sugar} #{order_list[x].extra}"
    end
end

def enter_exit
    puts "Please press any key to menu option"
    enter = gets
    while enter.empty?
        "Please press any key to menu option"
        enter = gets
    end
end

# code starts from here
system 'clear'
font = TTY::Font.new(:doom)
puts font.write("Welcome   to", letter_spacing: 2).colorize(:yellow)
puts font.write("* Coder Coffee", letter_spacing: 2).colorize(:yellow)
print TTY::Box.frame {"** Lets order your coffee through this terminal application **"}
puts "First, please = type your name."
name = Name.new.get_name
#calling greeting method to get customer's name
system 'clear'
puts "Hi, #{name}"
puts 'Would you like to plece an order today?'
order_list = []
order_list.push CustomiseCoffee.new.customise_coffee
# customise_coffee method creats instance of the coffee class
#and put into the array.
puts "[#{1}].#{order_list[0].size} #{order_list[0].type} #{order_list[0].milk} #{order_list[0].sugar} #{order_list[0].extra}"
# shows what items has been put in the order list
exit = false
# defined exit veriable to exit from the loop below
while exit == false
    option = show_menu()
    total_price = order_list.map {|coffee| coffee.get_price}.inject(:+)
    # calculation for total price of all items in order_list_array
    case option
    when "Add another item to order"
        system 'clear'
        order_list.push CustomiseCoffee.new.customise_coffee
        # adding new instance which is another customized coffee to the order list
    when "View order"
        system 'clear'
        puts "YOUR ORDER LIST"
        show_order_list(order_list)
        puts "Total price is $#{total_price}"
        enter_exit
    when "Check out"
        system 'clear'
        puts "YOUR ORDER LIST"
        show_order_list(order_list)
        # giving a choice to go back to menu or confirm the order depends on users input
        prompt = TTY::Prompt.new(symbols: {marker: '⬡'})
        answer = prompt.select("Would you like to confirm and send your order to Coder Cofffee?") do |menu|
            menu.choice 'Yes, I am ready'
            menu.choice 'No, go back to menu'
        end
           if answer == 'Yes, I am ready'
            system 'clear'
            puts "Thank you for your order, #{name}"
            puts "You order has been sent."
            puts font.write("Bye Bye", letter_spacing: 2).colorize(:blue)
            print = CustomiseCoffee.new.download_csv(name, order_list, total_price)
            exit = true
           end
        # upload_csv(send_order,total_price)
    when "Change/remove item from order"
        prompt = TTY::Prompt.new
        system 'clear'
        puts "YOUR ORDER LIST"
        show_order_list(order_list)
        puts "Total price is $#{total_price}"
        puts "Type a number of coffee you like to remove."
        number = gets
            while number.to_i > order_list.length
                box = TTY::Box.error("Type a number within the list")
                print box
                number = gets.chomp
            end
        order_list.delete_at(number.to_i-1)
        # order_list_array is assigned by a numerical index starting from 1. 
        # need to minus 1 from number as deleteing using the index of order_list_array
        system 'clear'
        puts "YOUR ORDER LIST HAS BEEN CHANGED"
        show_order_list(order_list)
        total_price = order_list.map{|coffee| coffee.get_price}.inject(:+)
        # calculating totalprice again after deleting item from order_array_list
        puts "Total price is now $#{total_price}"
        enter_exit
    when "Exit".colorize(:yellow)
        system 'clear'
        prompt = TTY::Prompt.new(symbols: {marker: '⬡'})
        answer = prompt.select("Are you sure you don't want coffee?") do |menu|
            menu.choice 'Yes, I am sure'
            menu.choice 'You are right. I might need coffee.'
        end
        if answer == 'Yes, I am sure'
            exit = true
        end
    end
end