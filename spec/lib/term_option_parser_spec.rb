require_relative '../../lib/term_option_parser'

RSpec.describe TermOptionParser do
  let(:parser) { TermOptionParser.new }

  describe '#parse!' do
    let(:args) {["-d", "10000", "-r", "5", "-t", "12", "-c", "month"]}

    it "parses options into profile" do
      parser.parse!(args)
      expect(parser.profile.deposit).to eq(10000)
      expect(parser.profile.rate).to eq(5)
      expect(parser.profile.term).to eq(12)
      expect(parser.profile.cycle).to eq(1)
    end

    context "with invalid deposit" do
      let(:args) {["-d", "500", "-r", "5", "-t", "12", "-c", "month"]}

      it "raises an InvalidArgument error" do
        expect { parser.parse!(args) }.to raise_error(OptionParser::InvalidArgument)
      end
    end

    context "with invalid rate" do
      let(:args) {["-d", "1000", "-r", "-5", "-t", "12", "-c", "month"]}

      it "raises an InvalidArgument error" do
        expect { parser.parse!(args) }.to raise_error(OptionParser::InvalidArgument)
      end
    end

    context "with invalid term" do
      it "raises an InvalidArgument error" do
        args = ["-d", "1000", "-r", "5", "-t", "1", "-c", "month"]
        expect { parser.parse!(args) }.to raise_error(OptionParser::InvalidArgument)
      end
    end

    context "with invalid cycle" do
      it "raises an InvalidArgument error" do
        args = ["-d", "1000", "-r", "5", "-t", "12", "-c", "week"]
        expect { parser.parse!(args) }.to raise_error(OptionParser::InvalidArgument)
      end
    end

    context "with annual interest cycle and term less than 12 months" do
      it "raises an InvalidArgument error" do
        args = ["-d", "1000", "-r", "5", "-t", "11", "-c", "year"]
        expect { parser.parse!(args) }.to raise_error(OptionParser::InvalidArgument)
      end
    end
  end
end