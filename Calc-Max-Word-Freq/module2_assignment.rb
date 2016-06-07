#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
	#Implement read-only attributes
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
	#* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content - the string analyzed (provided)
  #* line_number - the line number analyzed (provided)
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def highest_wf_words
  	@highest_wf_words
  end

  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #Implement the initialize() method to:
  def initialize (content, line_number)    #* take in a line of text and line number
    @content = content  
    @line_number = line_number  #* initialize the content and line_number attributes
    calculate_word_frequency  #* call the calculate_word_frequency() method.
    @content#, @line_number
  end
  
  #Implement the calculate_word_frequency() method to:
  def calculate_word_frequency
  	# puts "INSIDE calculate_word_frequency IN class LineAnalyzer"
  	# puts @content
    #* calculate the maximum number of times a single word appears within
    #  provided content and store that in the highest_wf_count attribute.
  	words = @content.chomp.split

    #* create & fill hash with word and the frequency that word appears in the collection of words
  	word_frequencies = Hash.new(0)
 	 	
 	 	words.each do |word|
  		word_frequencies[word.downcase] += 1
  	end

  	@highest_wf_count = 0
  	word_frequencies.each do |word, count|
			# puts "word: #{word}, count: #{count}"
  		if count > @highest_wf_count
  			@highest_wf_count = count
  		end
  		# puts "highest_wf_count: #{@highest_wf_count}"
  	end
 
  	#* identify the words that were used the maximum number of times and
    #  store that in the highest_wf_words attribute.
    @highest_wf_words = []
		word_frequencies.each do |word, count|
			# puts "word: #{word}, count: #{count}"
  		if count == @highest_wf_count
  			@highest_wf_words << word
  			# puts "highest_wf_words: #{@highest_wf_words}"
  		end
  	end
  	# puts "@highest_wf_count = #{@highest_wf_count}"
  	# puts "LEAVING calculate_word_frequency IN class LineAnalyzer"
  end
end

#  Implement a class called Solution. 
class Solution

  # Implement the following read-only attributes in the Solution class.
  #* analyzers - an array of LineAnalyzer objects for each line in the file
  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute 
  #  equal to the highest_count_across_lines determined previously.
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize
  	@analyzers = []
  end

  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  #* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and 
  #                                            highest_count_words_across_lines attribute values

  #* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in 
  #  highest_count_words_across_lines in the specified format
  
  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines 
  def analyze_file
  	lines = []
  	File.open("test.txt") do |file|
  		lines = file.readlines
  	end

	  #* Create an array of LineAnalyzers for each line in the file
  	index = 0
  	line_analyzers = []
  	while index < lines.length
 			# puts "Loop thru lines Creating LineAnalyzers ****** index #{index}******"
  		line_analyzers[index] = LineAnalyzer.new(lines[index], index + 1)
  		# puts "line_analyzers[index] = #{line_analyzers[index]}"
  		# puts "Print line_analyzers[index].highest_wf_words = #{line_analyzers[index].highest_wf_words}"
  		# @analyzers << line_analyzers[index].highest_wf_words
  		@analyzers << [line_analyzers[index].line_number, line_analyzers[index].highest_wf_words, line_analyzers[index].highest_wf_count]
  		# puts
  		# puts "@analyzers[0,index+1] = #{@analyzers[0,index+1]}     @analyzers[1,index+1] = #{@analyzers[1,index+1]}"
  		# puts
  		# p @analyzers
			index += 1  		
  	end
  end
 

# WORK ON PUTTING DATA IN analyzers ARRAY

  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #                                  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines 
  #  attribute value determined previously and stores them in highest_count_words_across_lines.
  def calculate_line_with_highest_frequency
  	index = 0
  	@highest_count_across_lines = 0

  	# puts "line     words     max"
   # 	@analyzers.each do |linenum, words, max|
  	# 	puts "#{linenum}  #{words}  #{max}"  		
  	# end
 
   	@analyzers.each do |linenum, words, max|
   		if max > @highest_count_across_lines
   			@highest_count_across_lines = max
   		end
  		# puts "#{linenum}  #{words}  #{max}   #{@highest_count_across_lines}"
  	end

  	@highest_count_words_across_lines = []
  	@analyzers.each do |linenum, words, max|
   		if max == @highest_count_across_lines
   			@highest_count_words_across_lines << words
   		end
  		# puts "#{@highest_count_words_across_lines}"
  	end
  	# @highest_count_words_across_lines.reverse!
  end

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format
  def print_highest_word_frequency_across_lines
  	@highest_count_words_across_lines.reverse!
  	puts "The following words have the highest word frequency per line:"
  	puts @highest_count_words_across_lines
  	@analyzers.each do |linenum, words, max|
   		if max == @highest_count_across_lines
  		 puts "#{words} (appears in line #{linenum})"
   		end
  	end
 	 end
end