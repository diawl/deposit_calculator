require_relative '../../lib/term_option_parser'

RSpec.describe TermOptionParser do
  let(:parser) { TermOptionParser.new }

  describe '#parse!' do
    let(:args) {["-d", "10000", "-r", "5", "-t", "12", "-c", "month"]}

    it "parses options" do
      parser.parse!(args)
      expect(parser.options.deposit).to eq(10000)
      expect(parser.options.rate).to eq(5)
      expect(parser.options.term).to eq(12)
      expect(parser.options.cycle).to eq("month")
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
  end
end