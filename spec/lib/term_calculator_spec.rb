require_relative '../../lib/term_calculator'
require_relative '../../lib/term_profile'

RSpec.describe TermCalculator do
  let(:profile) do
    profile = TermProfile.new
    profile.deposit = deposit
    profile.term = term
    profile.rate = rate
    profile.cycle = cycle
    profile
  end
  let(:calculator) { TermCalculator.new(profile) }
  
  describe '#calculate' do
    subject { calculator.calculate }
    let(:deposit) { 10000 }
    let(:term) { 12 }
    let(:rate) { 5.0 }
    
    context 'interest paid by month' do
      let(:cycle) { 1 }
      it { is_expected.to equal 10512 }
    end

    context 'interest paid by quarter' do
      let(:cycle) { 3 }
      it { is_expected.to equal 10509 }

      context 'term is not integer number of cycles' do
        let(:term) { 13 }
        it { is_expected.to equal 10553 }
      end
    end

    context 'interest paid by annual' do
      let(:cycle) { 12 }
      it { is_expected.to equal 10500 }

      context 'term is not integer number of cycles' do
        let(:term) { 13 }
        it { is_expected.to equal 10543 }
      end
    end

    context 'interest paid at maturity' do
      let(:cycle) { term }
      it { is_expected.to equal 10500 }

      context 'term is not integer number of years' do
        let(:term) { 13 }
        it { is_expected.to equal 10542 }
      end
    end
  end
end