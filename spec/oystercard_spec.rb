require 'oystercard'

describe Oystercard do

  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  context 'when initialize' do
    subject {
      Oystercard.new
    }
    it 'should have a balance by default' do
      expect(subject.balance).to eq 0
    end

    it 'should not be in journey if not touched in' do
      expect(subject.in_journey?).to eq false
    end

    it 'initially not in a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'should have a minimum amount with 1 as a constant' do
      expect(Oystercard::DEFAULT_MINIMUM_AMOUNT).to eq 1
    end

    it 'should have an empty list of journeys by default' do
      expect(subject.journeys).to eq []
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
      subject.touch_in(entry_station)
    end

    it 'should touch into a journey' do
      expect(subject.in_journey?).to eq true
    end

    it 'should after touch out not be in journey' do
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq false
    end

    it 'should deduct by the minimum fare if touch out' do
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by -Oystercard::DEFAULT_MINIMUM_AMOUNT
    end

    it 'should store entry_station' do
      expect(subject.entry_station).to eq entry_station
    end

    it 'should set entry_station to nil after touching out' do
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq nil
    end

    it 'should store a lists of journeys' do
      subject.touch_out(exit_station)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to eq [{ entry_station => exit_station }, { entry_station => exit_station }]
    end

    it 'should store a lists of journeys' do
      subject.touch_out(exit_station)
      expect(subject.journeys.length).to eq 1
    end

  end

  context 'not sufficient balance' do

    it "should raise an error if the balance doesn't reach the minimum amount" do
      expect { subject.touch_in(entry_station) }.to raise_error 'You do not have the minimum amount for a journey'
    end

  end

end
