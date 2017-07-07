#!/usr/bin/ruby

#functions
class Colors
	attr_accessor :red, :green, :blue, :numColors, :contrast, :maxContrast, :maxContrastIndex, :counter, :contrastOwner, :contrastAnswer
	def initialize(numColors)
		@red = Array.new
		@green = Array.new
		@blue = Array.new
		@numColors = numColors
		
		
		@contrast = Array.new(numColors){Array.new(numColors)}
		@maxContrast = 0
		@maxContrastIndex = -10000
		@contrastOwner = Array.new
		
		answer = Struct.new(:x,:y)
		@contrastAnswer = Array.new(numColors){}
		0.upto(numColors){|n|
			@contrastAnswer[n] = answer.new(0,0)
		}
	end
	def setRGB(file)
		numColors = file.gets.to_i
		current = Colors.new(numColors)
		1.upto(numColors){ |m|
			colors = file.gets
			r,g,b = colors.split(" ")
			@red.push(r.to_i)
			@green.push(g.to_i)
			@blue.push(b.to_i)
		}
	end
	def	calculate(counter)
		0.upto(numColors-1){|i|
			i2 = i + 1
			i2.upto(numColors-1){|j|
				#print i,j
				#puts
				@contrast[i][j] = ((red[i]-red[j])*(red[i]-red[j]) + (green[i]-green[j])*(green[i]-green[j]) + (blue[i]-blue[j])*(blue[i]-blue[j]))
				#puts "Contrast: ",contrast[i][j]
				#puts "Max Contrast: ",maxContrast
				if contrast[i][j] > maxContrast
					@maxContrast = contrast[i][j]
					@maxContrastIndex = 0
					@contrastAnswer[maxContrastIndex].x = i+1
					@contrastAnswer[maxContrastIndex].y = j+1
					#print contrastAnswer
				elsif contrast[i][j] == maxContrast
					@maxContrastIndex += 1
					@contrastAnswer[maxContrastIndex].x = i+1
					@contrastAnswer[maxContrastIndex].y = j+1
				end
			}
		}
		#print contrastAnswer[1].x
		#puts maxContrastIndex
		#print "DataSet ",counter,"\n"
		#puts contrastAnswer[0].x
		answer = Array.new(maxContrastIndex+1){Array.new(2)}
		0.upto(maxContrastIndex){|n|
			answer[n][0] = contrastAnswer[n].x
			answer[n][1] = contrastAnswer[n].y
		}
		return answer
	end
end

#functions needed
#method to read header
def readHeader(file)
	return file.gets.to_i
end

#method to read particular data set
#returns data that needs to passed on to calculate

#method that takes result of computation and prints it

#method that combines these p

#main function
file = File.new("colors.in.txt","r")

#first line is the number of data sets
numSets = readHeader(file)
puts "# of sets: #{numSets}"
counter = 1
numSets.downto(1){ 
	|n| 
	
	current = Colors.new(file.gets.to_i)
	current.setRGB(file)
	answer = current.calculate(counter)
	print "DataSet ", counter
	0.upto(answer.length){|n|
		print "\n",answer[n]
	}
	counter += 1
	
}

file.close()
puts "End"

