require 'oystercard'

describe Oystercard do

  it 'should have a balance by default' do
    expect(subject.balance).to eq 0
  end

  it 'should top_up' do
    subject.top_up(5)
    expect(subject.balance).to eq 5
  end

end
