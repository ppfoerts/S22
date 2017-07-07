#!/usr/bin/ruby

check = false
[-4,1,2,255].each{ |a| if not a.between?(0,255); check = true; end}
raise TypeError, 'Value has to be between 0-255' if check == true
