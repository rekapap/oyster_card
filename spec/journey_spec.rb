require 'journey'

describe Journey do

  let(:station) { double :station, zone: 1 }

  it 'knows if a journey is not complete' do
    expect(subject).not_to be_complete
  end

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it 'returns itself when exiting a journey' do
    expect(subject.finish(station)).to eq(subject)
  end


  context 'given an entry station' do

    subject {described_class.new(entry_station: station) }

    it 'has an entry station' do
      expect(subject.entry_station).to eq station
    end

    it 'returns a penalty fare if no exit station given' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    context 'given an exit station' do
      let(:other_station) { double :other_station, zone: 1 }

      before do
        subject.finish(other_station)
      end

      it 'calculates a fare' do
        expect(subject.fare).to eq 1
      end

      it 'knows if a journey is complete' do
        expect(subject).to be_complete
      end
    end

    describe '#fare' do

      let(:station_1) { double :station_1, zone: 1 }
      let(:station_2) { double :station_2, zone: 2 }
      let(:station_6) { double :station_6, zone: 6 }
      
      context 'same zone' do
        subject { described_class.new(entry_station: station_1) }

        it 'it calculates the fare between stations' do
          subject.finish(station_1)
          expect(subject.fare).to eq 1
        end

      end

      context 'different zone' do
        subject { described_class.new(entry_station: station_2) }
  
        it 'it calculates the fare between stations' do
          subject.finish(station_6)
          expect(subject.fare).to eq 5
        end

      end
    end
  end
end