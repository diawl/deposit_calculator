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
    (deposit * (1 + interest_rate_per_cycle) ** number_of_cycles).round
  end

  private

  def interest_rate_per_cycle
    cycle * rate / 12 / 100
  end

  def number_of_cycles
    term / cycle
  end
end