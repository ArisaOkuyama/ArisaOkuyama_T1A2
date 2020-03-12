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

