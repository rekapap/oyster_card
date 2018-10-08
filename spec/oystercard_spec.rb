require 'oystercard'

describe Oystercard do

  it 'should have a balance by default' do
    expect(subject.balance).to eq 0
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

  it 'should deduct amount from balance' do
    subject.top_up(5)
    expect { subject.deduct(3) }.to change { subject.balance }.by -3
  end

  it 'should touch into a journey' do
    subject.top_up(5)
    subject.touch_in
    expect(subject.in_journey?).to eq true
  end

  it 'should not be in journey if not touched in' do
    expect(subject.in_journey?).to eq false
  end

  it 'should after touch out not be in journey' do
    subject.top_up(5)
    subject.touch_in
    subject.touch_out
    expect(subject.in_journey?).to eq false
  end

  it 'initially not in a journey' do
    expect(subject).not_to be_in_journey
  end

  it 'should have a minimum amount' do
    expect { subject.touch_in }.to raise_error "You do not have the minimum amount for a journey"
  end

end
