require 'oystercard'
require 'journey_log'
require 'journey'

describe Oystercard do

  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey) { double :journey }
  let(:journeylog) { double :journeylog }
  subject { Oystercard.new(journeylog) }

  context 'when initialize' do

    it 'should have a balance by default' do
      expect(subject.balance).to eq 0
    end

    it 'initially not in a journey' do
      allow(journeylog).to receive(:current_journey).and_return(journey)
      allow(journey).to receive(:complete?).and_return(false)
      expect(subject).not_to be_in_journey
    end

    it 'should have a minimum amount with 1 as a constant' do
      expect(Oystercard::DEFAULT_MINIMUM_AMOUNT).to eq 1
    end
  end

  it 'should top_up' do
    subject.top_up(5)
    expect(subject.balance).to eq 5
  end

  it 'should raise an error if exceeded maximum amount' do
    max_amount = Oystercard::DEFAULT_MAXIMUM_AMOUNT
    subject.top_up(max_amount)
    expect { subject.top_up(1) }.to raise_error "Maximum amount = #{max_amount}"
  end

  context 'top up and touch in' do
    before(:each) do
      subject.top_up(5)
      allow(journeylog).to receive(:current_journey).and_return(journey)
      allow(journey).to receive(:complete?).and_return(true)
      allow(journey).to receive(:fare).and_return(6)
      allow(journeylog).to receive(:start)
      subject.touch_in(entry_station)
    end

    it 'fines the person if touch in twice' do
      allow(journeylog).to receive(:current_journey).and_return(journey)
      allow(journey).to receive(:complete?).and_return(false)
      allow(journeylog).to receive(:finish)
      expect { subject.touch_in(entry_station) }.to raise_error Oystercard::BEEN_FINED
    end

    it 'should touch into a journey' do
      expect(subject.in_journey?).to eq true
    end

    it 'should after touch out not be in journey' do
      allow(journeylog).to receive(:finish).and_return(nil)
      allow(journey).to receive(:fare).and_return(1)
      allow(journey).to receive(:complete?).and_return(true)
      subject.touch_out(exit_station)
      allow(journeylog).to receive(:current_journey).and_return(journey)
      allow(journey).to receive(:complete?).and_return(false)
      expect(subject.in_journey?).to eq false
    end

    it 'should deduct by the minimum fare if touch out' do
      allow(journeylog).to receive(:finish).and_return(nil)
      allow(journey).to receive(:fare).and_return(1)
      allow(journey).to receive(:complete?).and_return(true)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by -Journey::MIN_FARE
    end
  end

  context 'not sufficient balance' do
    it "should raise an error if the balance doesn't reach the minimum amount" do
      allow(journeylog).to receive(:current_journey).and_return(journey)
      allow(journey).to receive(:complete?).and_return(true)
      expect { subject.touch_in(entry_station) }.to raise_error Oystercard::NO_MIN_AMOUNT
    end
  end
end
