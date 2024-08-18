require_relative 'lib/term_calculator'
require_relative 'lib/term_option_parser'

begin
  option_parser = TermOptionParser.new
  option_parser.parse!(ARGV)
  puts "$#{TermCalculator.new(option_parser.profile).calculate}"
rescue StandardError => error
  puts "Error: #{error.message}"
end