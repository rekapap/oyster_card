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
    subject.top_up(1)
    expect { subject.top_up(Oystercard::DEFAULT_MAXIMUM_AMOUNT) }.to raise_error "Maximum amount = #{Oystercard::DEFAULT_MAXIMUM_AMOUNT}"
  end

end
