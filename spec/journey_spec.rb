require "journey"

describe Journey do
  let(:station) {double :station, zone: 3}
  context 'given an entry station' do
    subject { described_class.new(entry_station: station)}

    it "stores the entry station" do
      expect(subject.entry_station).to eq station
    end

  end
end
