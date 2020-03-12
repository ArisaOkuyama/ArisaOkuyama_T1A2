require 'test/unit'
require "tty-box"
require_relative 'coffee'

# def greeting
#     name = gets.chomp
#     while name.empty?
#         box = TTY::Box.error("Please type your name")
#         print box
#         name = gets.chomp
#     end
#     system 'clear'
#     return name
# end

class TestSample < Test::Unit::TestCase
  def test_coffee_size_small
    coffee = Coffee.new("Flat White", 'Small',"Full Milk",'1 Sugar','No thank you')
    assert_equal 'Small', coffee.size
  end
  
  # A small normal coffee is $3.50
  def test_coffee_size_price
    coffee = Coffee.new("Flat White", 'Small',"Full Milk",'1 Sugar','No thank you')
    assert_equal 3.5, coffee.get_price
  end
  def test_coffee_size_price
    coffee = Coffee.new("Flat White", 'Small',"Full Milk",'1 Sugar','No thank you')
    assert_equal 3.5, coffee.get_price
  end
end
