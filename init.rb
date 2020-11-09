#!/usr/bin/env/ ruby

require_relative 'classes/calculator.rb'

begin
    c = Calculator.new(10)
    c.add(20)
    c.sub(40)
    c.result
    c.div(0)
rescue => exception
    puts exception
    
end


