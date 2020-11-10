class Calculator
    @result = 0
        
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
        @result
    end

end