class TermCalculator
  # deposit: initial deposit amount
  # term: number of months in this saving term
  # rate: annual interest rate
  # cycle: interest payment cycle in months
  attr_reader :deposit, :term, :rate, :cycle

  def initialize(deposit, term, rate, cycle)
    @deposit = deposit
    @term = term
    @rate = rate
    @cycle = cycle
  end

  def calculate
    (deposit * full_cycle * partial_cycle).round
  end

  private

  def interest_rate_per_cycle
    cycle * rate / 12 / 100
  end

  def number_of_cycles
    term / cycle
  end

  # monthly interest rate used for calculating partial cycle interest
  # it works as if it's re-investing every month and generating the 
  # same amount of interest by the end of interest payment cycle
  def partial_monthly_rate
    (1 + interest_rate_per_cycle) ** (1.0/cycle) - 1
  end

  # number of months remaining outside of full interest payment cycle
  def partial_cycle_months
    term % cycle
  end

  # interest generated from full interest payment cycle
  def full_cycle
    (1 + interest_rate_per_cycle) ** number_of_cycles
  end
  
  # interest generated outside of full interest payment cycle
  def partial_cycle
    (1 + partial_monthly_rate) ** partial_cycle_months
  end
end