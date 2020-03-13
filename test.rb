require 'test/unit'
require_relative 'coffee'

class TestSample < Test::Unit::TestCase
  def test_coffee_size_small
    coffee = Coffee.new("Flat White", 'Small',"Full Milk",'1 Sugar','No thank you')
    assert_equal 'No thank you', coffee.extra
  end
  
  # A small Almond milk coffee is $3.50
  def test_coffee_price
    coffee = Coffee.new("Flat White", 'Small',"Almond Milk",'1 Sugar','No thank you')
    assert_equal 4.0, coffee.get_price
  end
  # A large normal milk coffee is $5
  def test_price_large
    coffee = Coffee.new("Flat White", 'Large',"Full Milk",'4 Sugar','No thank you')
    assert_equal 5, coffee.get_price
  end
  
end
