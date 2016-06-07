require_relative "module2_assignment"

# This script provides a sample execution of the Solution class
# that is consistent with what the rspec evaluation will perform.
# You may use it to sanity check your actual solution along side
# the rspec tests.

solution = Solution.new
puts "Begin"
#expect errors until you implement these methods
solution.analyze_file
puts "analyzed"
solution.calculate_line_with_highest_frequency
puts "calculated"
solution.print_highest_word_frequency_across_lines
puts "End Program"