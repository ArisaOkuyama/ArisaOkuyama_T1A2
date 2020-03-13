class Name
    attr_reader :name
    def get_name
        name = gets.chomp
        while name.empty?
            box = TTY::Box.error("Please type your name")
            print box
            name = gets.chomp
        end
        system 'clear'
        return name
    end
end