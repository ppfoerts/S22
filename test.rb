#!/usr/bin/ruby

class Dataset
	attr_accessor :num
	attr_accessor :colors
	
	def initialize(number,colors)
		@num = number
		@colors = colors
	end
	
	def print()
		for i in 1..colors.length-1
			@colors[i].print()
		end
	end
end

class RGB
	attr_accessor :R
	attr_accessor :G
	attr_accessor :B
	def initialize(r,g,b)
		@R = r
		@G = g
		@B = b
	end
	def print()
		puts "#{@R},#{@G},#{@B}"
	end
end

class OneSet
	attr_accessor :row1
	attr_accessor :row2
	attr_accessor :contr
	
	def initialize(r1,r2,con)
		@row1 = r1
		@row2 = r2
		@contr = con
	end
end

class Output
	attr_accessor :row1
	attr_accessor :row2
	
	def initialize(r1,r2)
		@row1 = r1
		@row2 = r2
	end	
end

def calculate_contrast(set1, set2)
	rdif = set1.R - set2.R
	gdif = set1.G - set2.G
	bdif = set1.B - set2.B

	sr = Math.sqrt(rdif*rdif+gdif*gdif+bdif*bdif)
	
	sr
end

file = File.new("colors.in.txt","r")

#first line is the number of data sets
numSets = file.gets.to_i
#puts "# of sets: #{numSets}"
#the rest of the lines need to be processed

#first by number of sets
sets = Array.new(numSets)
for i in 1..numSets
	#then number of colors
	numColors = file.gets.to_i
	# puts "# of colors: #{numColors}"
	m = Array.new(numColors)
	for j in 1..numColors	
		_R,_G,_B = file.gets.split(" ").map(&:to_i)
		# puts $R
		# puts $G
		# puts $B
		# puts "\n"
		m[j] = RGB.new(_R,_G,_B)
	end
	sets[i] = Dataset.new(i,m)
end

#puts sets[12].print()

#output
for i in 1..numSets
	setNumber = i
	puts "Data Set #{setNumber} :"
	
	current = sets[i].colors
	possibleCombos = (current.length-1) * (current.length-1) - (current.length-1)
	#make Oneset
	combos = Array.new(possibleCombos)
	index = 0
	
	#calculate contrast
	for a in 1..current.length-1
		for b in 1..current.length-1
			if a == b
				next
			else
				combos[index] = OneSet.new(a,b,calculate_contrast(current[a],current[b]))
				index += 1
			end
		end
	end
	
	
	#get the contrast only
	contrast_array = Array.new(combos.length)
	for i in 0..combos.length-1
		contrast_array[i] = combos[i].contr
	end
	
	contrast_array.sort
	
	highest_contrast = contrast_array[contrast_array.length-1]
	output = Array.new()
	
	for k in 0..combos.length-1
		if combos[k].contr == highest_contrast
			row1 = combos[k].row1
			row2 = combos[k].row2
			
			output.push(Output.new(row1,row2))
		end
	end
	
	
	
	#delete_if deletes the element when returned true
	output.delete_if do |d|
		output.delete_if do |g|
			if d.row1 == g.row2 && d.row2 == g.row1
				if d.row1 < d.row2
					true
				else
					false
				end
			else
				false
			end
		end
		false
	end
	
	for i in 0..output.size-1
		row1 = output[i].row1+1
		row2 = output[i].row2+1
		puts "#{row1} #{row2}"
	end
end

file.close
puts "End"

Time.new
sleep 10.0

