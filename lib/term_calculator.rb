class TermCalculator
  attr_reader :profile

  def initialize(profile)
    @profile = profile
  end

  def calculate
    (profile.deposit * full_cycle * partial_cycle).round
  end

  private

  # interest generated from full interest payment cycle
  def full_cycle
    (1 + profile.interest_rate_per_cycle) ** profile.number_of_cycles
  end
  
  # interest generated outside of full interest payment cycle
  def partial_cycle
    (1 + profile.partial_monthly_rate) ** profile.partial_cycle_months
  end
end