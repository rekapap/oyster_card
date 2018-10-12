# JourneyLog
class JourneyLog
  def initialize(journey_class:)
    @journey_class = journey_class
    @journeys = []
  end

  def start(entry_station)
    @current_journey = @journey_class.new(entry_station: entry_station)
    store(@current_journey)
  end

  def finish(exit_station)
    current_journey.finish(exit_station)
    @current_journey = nil
  end

  def journeys
    @journeys.dup
  end

  private

  def store(journey)
    @journeys << journey
  end

  def current_journey
    @current_journey ||= @journey_class.new
  end
end
