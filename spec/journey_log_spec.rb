require 'journey_log'
require 'journey'

describe JourneyLog do
  let(:station) { double :station }
  let(:journey) { double :journey, start: station, finish: self } # journey object
  let(:journeys) { [journey] }
  let(:journey_class) { double :journey_class, new: journey } # journey class
  subject { JourneyLog.new(journey_class: journey_class) }
 
  describe '#start' do
    it '#start should start a new journey with an entry station' do
      expect(journey_class).to receive(:new).with(entry_station: station)
      subject.start(station)
    end

    it 'records a journey' do
      allow(journey_class).to receive(:new).and_return journey
      subject.start(station)
      expect(subject.journeys).to include journey
    end
  end

  describe '#finish' do
    it '#finish should add an exit station to the current_journey' do
      allow(journey_class).to receive(:new).and_return journey
      subject.start(station)
      expect(journey).to receive(:finish).with(station)
      subject.finish(station)
    end
  end

  describe '#journeys' do
    it '#journeys should return a list of all previous journeys without exposing the internal array to external modification' do
      allow(journey_class).to receive(:new).with(entry_station: station).and_return journey
      subject.start(station)
      subject.finish(station)
      expect(subject.journeys.object_id).to_not eq journeys.object_id
    end
  end
end
