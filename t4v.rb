#!/usr/bin/ruby


#functions needed
#method to read header
def readHeader(name)
	file = File.new(name,"r")
	return file.gets.to_i
end

#method to read particular data set
#returns data that needs to passed on to calculate
class DataSet
	attr_accessor :red, :green, :blue, :numColors
	def initialize(numColors)
		@red = Array.new
		@green = Array.new
		@blue = Array.new
		@numColors = numColors
	end
	def setRGB(file)
		1.upto(numColors){ |m|
			colors = file.gets
			r,g,b = colors.split(" ")
			@red.push(r.to_i)
			@green.push(g.to_i)
			@blue.push(b.to_i)
		}
	end
	def setRGB2(colors)
		0.upto(numColors-1){ |m|
			@red.push(colors[m][0])
			@green.push(colors[m][1])
			@blue.push(colors[m][2])
		}
	end
end

def makeSet(numColors,colors)
	current = DataSet.new(numColors)
	current.setRGB2(colors)
	return current
end

#method that takes result of computation and prints it
def compute(set)
	numColors = set.numColors
	red = set.red
	green = set.green
	blue = set.blue
	
	contrast = Array.new(numColors){Array.new(numColors)}
	maxContrast = 0
	maxContrastIndex = -10000
	contrastOwner = Array.new
		
	answer = Struct.new(:x,:y)
	contrastAnswer = Array.new(numColors){}
	0.upto(numColors){|n|
		contrastAnswer[n] = answer.new(0,0)
	}
	
	0.upto(numColors-1){|i|
			i2 = i + 1
			i2.upto(numColors-1){|j|
				#print i,j
				#puts
				#check if value is between 0 and 255
				check = false
				[red[i],red[j],green[i],green[j],blue[i],blue[j]].each{ |a| if not a.between?(0,255); check = true; end}
				raise TypeError, 'Value has to be between 0-255' if check == true
				contrast[i][j] = ((red[i]-red[j])*(red[i]-red[j]) + (green[i]-green[j])*(green[i]-green[j]) + (blue[i]-blue[j])*(blue[i]-blue[j]))
				#puts "Contrast: ",contrast[i][j]
				#puts "Max Contrast: ",maxContrast
				if contrast[i][j] > maxContrast
					maxContrast = contrast[i][j]
					maxContrastIndex = 0
					contrastAnswer[maxContrastIndex].x = i+1
					contrastAnswer[maxContrastIndex].y = j+1
					#print contrastAnswer
				elsif contrast[i][j] == maxContrast
					maxContrastIndex += 1
					contrastAnswer[maxContrastIndex].x = i+1
					contrastAnswer[maxContrastIndex].y = j+1
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

#create random list of data
def randData(num,seed)
	randAr = Array.new(num){Array.new(3){0}}
	srand seed
	0.upto(num-1){ |n|
		randAr[n][0] = rand(255)
		randAr[n][1] = rand(255)
		randAr[n][2] = rand(255)
	}
	
	return randAr
end

#method that combines these pieces
def combine(name)
	#main function
	file = File.new(name,"r")

	#first line is the number of data sets
	numSets = readHeader(name)
	file.gets.to_i #go past the header
	puts "# of sets: #{numSets}"
	counter = 1
	numSets.downto(1){ 
		|n| 
		
		print "DataSet ", counter
		numColors = file.gets.to_i
		colors = Array.new(numColors){Array.new(3){0}}
		0.upto(numColors-1){ |m|
			line = file.gets
			r,g,b = line.split(" ")
			hello = []
			colors[m][0] = r.to_i
			colors[m][1] = g.to_i
			colors[m][2] = b.to_i
		}
		
		#print colors
		current = makeSet(numColors,colors)
		answer = compute(current)
		print answer
		puts
		counter += 1
		}
	file.close()
end


("colors.in.txt")

puts "End"