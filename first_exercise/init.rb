#!/usr/bin/env/ ruby

require_relative 'classes/calculator.rb'
require_relative 'classes/load_calculator.rb'

begin
    # c = Calculator.new()
    # c.add(20)
    # c.sub(40)
    # c.result
    # c.div(0)

    pth = LoadCalculator.new('assets/hello.csv')
    pth.display
rescue => exception
    puts exception
    
end


