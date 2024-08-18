require_relative 'lib/term_calculator'
require_relative 'lib/term_option_parser'

option_parser = TermOptionParser.new
option_parser.parse!(ARGV)

puts "$#{TermCalculator.new(option_parser.profile).calculate}"