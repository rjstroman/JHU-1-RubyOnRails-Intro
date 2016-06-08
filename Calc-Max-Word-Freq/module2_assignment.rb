#Implement all parts of this assignment within (this) module2_assignment2.rb file
#Implement a class called LineAnalyzer.
class LineAnalyzer
	#Implement read-only attributes
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
	#* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content - the string analyzed (provided)
  #* line_number - the line number analyzed (provided)
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #Implement the initialize() method to:
  def initialize (content, line_number)    #* take in a line of text and line number
    @content = content  
    @line_number = line_number  #* initialize the content and line_number attributes
    @highest_wf_words = []
    @highest_wf_count = 0
    calculate_word_frequency  #* call the calculate_word_frequency() method.
    @content#, @line_number
  end
  #Implement the calculate_word_frequency() method to:
  def calculate_word_frequency
    #* calculate the maximum number of times a single word appears within
    #  provided content and store that in the highest_wf_count attribute.
  	words = @content.chomp.split

    #* create & fill hash with word and the frequency that word appears in the collection of words
  	word_frequencies = Hash.new(0)
 	 	
 	 	words.each do |word|
  		word_frequencies[word.downcase] += 1
  	end

  	word_frequencies.each do |word, count|
  		if count > @highest_wf_count
  			@highest_wf_count = count
  		end
  	end
  	#* identify the words that were used the maximum number of times and
    #  store that in the highest_wf_words attribute.
		word_frequencies.each do |word, count|
  		if count == @highest_wf_count
  			@highest_wf_words << word
  		end
  	end
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
  	# index = 0
		line_position = 1  	
  	# while index < lines.length
  	# 	@analyzers << LineAnalyzer.new(lines[index], index + 1)
			# index += 1  		
  	# end

  	lines.each do |line|
  		@analyzers << LineAnalyzer.new(line, line_position)
  		line_position += 1
  	end
  end
  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #                                  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines 
  #  attribute value determined previously and stores them in highest_count_words_across_lines.
  def calculate_line_with_highest_frequency
  	@highest_count_across_lines = 0
  	@highest_count_words_across_lines = []

   	@analyzers.each do |analyzer|
   		if analyzer.highest_wf_count > @highest_count_across_lines
   			@highest_count_across_lines = analyzer.highest_wf_count
   		end
  	end

  	@analyzers.each do |analyzer|
   		if analyzer.highest_wf_count == @highest_count_across_lines
   			@highest_count_words_across_lines << analyzer
   		end
  		# puts "#{@highest_count_words_across_lines}"
  	end
  end
  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format
  def print_highest_word_frequency_across_lines
  	puts "The following words have the highest word frequency per line:"
  	@analyzers.each do |analyzer|
   		if analyzer.highest_wf_count == @highest_count_across_lines
  		 puts "#{analyzer.highest_wf_words} (appears in line #{analyzer.line_number})"
   		end
  	end
 	end
end