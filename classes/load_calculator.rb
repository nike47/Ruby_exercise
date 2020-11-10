require 'csv'
require_relative 'calculator.rb'

class LoadCalculator
    
    def initialize(path)
        @path = path
    end
    


    def display
        load
        @answers = []
        # @calculator = Calculator.new()
        @csv.each do |row|
            @calculator = Calculator.new(row[0].to_i)
            @iter = 1
            while @iter <= row.length
                if row[@iter] == '+'
                    @calculator.add(row[@iter+1].to_i)
                elsif row[@iter] == '-'
                    @calculator.sub(row[@iter+1].to_i)
                elsif row[@iter] == '*'
                    @calculator.mult(row[@iter+1].to_i)
                elsif row[@iter] == '/'
                    @calculator.div(row[@iter+1].to_i)

                end
                @iter+=2
            end
            @answers << @calculator.result
            row<< @calculator.result
            puts row
            
        end
        # print @answers
        # # @csv << @answers
        # @answers.each do |ans|
        #     puts [ans]
        #     @csv << [ans]
        # end
    end

    private

    def load
        @csv = CSV.open(@path,"a+",:headers => false)
    end
end