class TermProfile
  # deposit: initial deposit amount
  # term: number of months in this saving term
  # rate: annual interest rate
  # cycle: interest payment cycle in months
  attr_accessor :deposit, :rate, :term, :cycle

  def number_of_cycles
    term / cycle
  end

  def interest_rate_per_cycle
    cycle * interest_rate_per_month
  end

  def interest_rate_per_month
    rate / 12 / 100
  end

    # monthly interest rate used for calculating partial cycle interest
  # it works as if it's re-investing every month and generating the 
  # same amount of interest by the end of interest payment cycle
  def partial_monthly_rate
    (1 + interest_rate_per_cycle) ** (1.0 / cycle) - 1
  end

  # number of months remaining outside of full interest payment cycle
  def partial_cycle_months
    term % cycle
  end
end