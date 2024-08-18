require 'optparse'
require 'ostruct'

class TermOptionParser
  attr_reader :options, :parser

  MIN_TERM = 3
  MAX_TERM = 60
  MIN_DEPOSIT = 1000
  MAX_DEPOSIT = 1500000
  VALID_CYCLE = ["month", "quarter", "year","at_maturity"].freeze

  def initialize
    @options = OpenStruct.new
    @parser = OptionParser.new
    define_options
  end

  def parse!(args)
    parser.parse!(args)
    validate
  end

  private

  def validate
    if options.term < 12 && options.cycle == "year"
      raise OptionParser::InvalidArgument, "Term must be at least 12 months to use a yearly interest frequency"
    end
  end

  def define_options
    parser.banner = "Usage: deposit_calculator [options]"
    parser.on("-dDeposit", "--deposit=DEPOSIT", Integer, "Initial deposit, integer only") do |d|
      if d < MIN_DEPOSIT || d > MAX_DEPOSIT
        raise OptionParser::InvalidArgument, "Deposit must be between 1,000 and 1,500,000."
      end
      options.deposit = d
    end
    parser.on("-rRate", "--rate=RATE", Float, "Percentage annual interest rate") do |r|
      if r < 0
        raise OptionParser::InvalidArgument, "Interest rate must be positive"
      end
      options.rate = r
    end
    parser.on("-tTerm", "--term=TERM", Integer, "Investment term in months") do |t|
      if t < MIN_TERM || t > MAX_TERM
        raise OptionParser::InvalidArgument, "Term must be between 3 and 60 months"
      end
      options.term = t
    end
    parser.on("-cCycle", "--cycle=Cycle", "Interest payment cycle") do |c|
      if VALID_CYCLE.include?(c)
        options.cycle = c
      else
        raise OptionParser::InvalidArgument, "Invalid Cycle. Must be one of: #{VALID_CYCLE.join(', ')}"
      end
    end
  end
end