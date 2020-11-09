#!/usr/bin/env/ ruby

require_relative 'classes/calculator.rb'
begin
    c = Calculator.new(t)
    c.add(20)
    c.sub(40)
    c.result
rescue => exception
    puts exception
    
end


