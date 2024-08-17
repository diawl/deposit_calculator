require_relative '../../lib/term_calculator'

RSpec.describe TermCalculator do
  let(:calculator) { TermCalculator.new(deposit, term, rate, cycle) }
  
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
    end

    context 'interest paid by annual' do
      let(:cycle) { 12 }
      it { is_expected.to equal 10500 }
    end

    context 'interest paid at maturity' do
      let(:cycle) { term }
      it { is_expected.to equal 10500 }
    end
  end
end