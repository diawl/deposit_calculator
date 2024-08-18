require 'byebug'
require_relative 'lib/term_calculator'
require_relative 'lib/term_option_parser'

option_parser = TermOptionParser.new
option_parser.parse!(ARGV)

options = option_parser.options

cycle = case options.cycle
when "month"
  1
when "quarter"
  3
when "year"
  12
when "at_maturity"
  options.term
end
puts "$#{TermCalculator.new(options.deposit, options.term, options.rate, cycle).calculate}"