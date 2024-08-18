require 'optparse'
require 'ostruct'
require 'byebug'
require_relative 'lib/term_calculator'

valid_cycle = ["month", "quarter", "year","at_maturity"]

options = OpenStruct.new

OptionParser.new do |parser|
  parser.banner = "Usage: deposit_calculator [options]"
  parser.on("-dDeposit", "--deposit=DEPOSIT", Integer, "Initial deposit, integer only") do |d|
    options.deposit = d
  end
  parser.on("-rRate", "--rate=RATE", Float, "Percentage annual interest rate") do |r|
    options.rate = r
  end
  parser.on("-tTerm", "--term=TERM", Integer, "Investment term in months") do |t|
    options.term = t
  end
  parser.on("-cCycle", "--cycle=Cycle", "Interest payment cycle") do |c|
    options.cycle = c 
  end
end.parse!

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