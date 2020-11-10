class Calculator
    @result = 0
        
    def initialize(val)
        # if !val.is_number?
        #     puts val
        #     raise "This is not a number"
        # end
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
        @result
    end

end