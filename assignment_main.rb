require "tty-prompt"
require "csv"
# require 'ruby_figlet'
require_relative './coffee'

def show_menu_option
    prompt = TTY::Prompt.new
    options = prompt.select("Please select one of the options") do |menu|
        menu.choice 'Add another item to order' 
        menu.choice 'Change/remove item from order' 
        menu.choice 'View order'
        menu.choice 'Check out'
        menu.choice 'Exit'
    end
    return options
end

# class Get_name
#     attr_reader :name
#     def initialize(name)
#         @name = name
#     end 
# end 

def show_order_list(order_list_array)
    for x in 0..(order_list_array.length - 1)
        puts "[#{x+1}].#{order_list_array[x].size} #{order_list_array[x].type} #{order_list_array[x].milk} #{order_list_array[x].sugar} #{order_list_array[x].extra}"
    end 
end
# def instance_to_array(order_list_array)
#     print_array = []
#     for x in 0..(order_list_array.length - 1)
#        order_list_array[x].size, order_list_array[x].type, order_list_array[x].milk
#     end 
#     return print_array
# end


def download_csv(order_list_array)
    # To a file
    CSV.open("./file.csv", "w") do |csv|
      csv << [order_list_array[0].type]
      csv << [order_list_array[0].size]
      csv << [order_list_array[0].milk]
     end
end

def greeting
    name = gets.chomp
    while name.empty?
        puts "Please type your name"
        name = gets.chomp
    end
    system 'clear'
    return name
end

system 'clear'
# two_lines = RubyFiglet::Figlet.new "Welcome to\nCoder Coffee", 'basic'
# two_lines.show

puts "Welcome to Coder Coffee"
puts "First, please type your name."
name = greeting
#calling greeting method to get customer's name
system 'clear'
puts "Hi, #{name}"
puts 'Would you like to plece an order today?'

order_list_array = []
order_list_array.push customise_coffee
# customise_coffee method creats instance of the coffee class and put into the array.
show_order_list(order_list_array)
# shows what items has been put in the order list
exit = false
# defined exit veriable to exit from the loop below
while exit == false
    selected_option = show_menu_option()
    total_price = order_list_array.map {|coffee| coffee.get_price}.inject(:+)
    # calculation for total price of all items in order_list_array
    case selected_option
    when "Add another item to order"
        system 'clear'
        order_list_array.push customise_coffee
        # adding new instance which is another customized coffee to the order list
    when "View order"
        prompt = TTY::Prompt.new
        system 'clear'
        puts "YOUR ORDER LIST"
        show_order_list(order_list_array)
        puts "Total bill is $#{total_price}"
        prompt.yes?('Press Enter or type yes to go back to menu.')
    when "Check out"
        system 'clear'
        prompt = TTY::Prompt.new
        show_order_list(order_list_array)
        puts "Thank you for your order, #{name}"
        puts "It's going to be $#{total_price} for today"
        puts "Type yes to confirm your order, no to go back to menu"
        # giving a choice to go back to menu or confirm the order depends on users input
        answer = gets.chomp
        if answer == 'Yes' or answer == 'yes' or  answer == 'y'
            puts "Thank you for your order, #{name}"
            download_csv(order_list_array)
            exit = true
        end
        # download_csv(send_order,total_price)
    when "Change/remove item from order"
        prompt = TTY::Prompt.new
        system 'clear'
        puts "YOUR ORDER LIST"
        show_order_list(order_list_array)
        puts "Total bill is $#{total_price}"
        puts "which number of coffee would like to remove from list?"
        number = gets.chomp
        order_list_array.delete_at(number.to_i-1)
        # order_list_array is assigned by a numerical index starting from 1. 
        # need to minus 1 from number as deleteing using the index of order_list_array
        system 'clear'
        puts "NoW, YOUR ORDER LIST"
        show_order_list(order_list_array)
        total_price = order_list_array.map{|coffee| coffee.get_price}.inject(:+)
        # calculating totalprice again after deleting item from order_array_list
        puts "Now you total bill is $#{total_price}"
        prompt.yes?('Press Enter or type yes to go back to menu.')
    when "Exit"
        exit = true
    end
end