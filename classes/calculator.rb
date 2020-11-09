class Calculator
    @result = 0
    begin
    def initialize(val)
        @result = val
        
    end

    def sub(value)
        @result -= value
    end

    def add(value)
        @result += value
    end

    def mult(value)
        @result *= value
    end

    def div(value)
        @result /= value
    end

    def result
        puts @result
    end

rescue Exception => e
    puts e.message
end

end