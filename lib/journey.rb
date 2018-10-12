# Journey
class Journey
  attr_reader :entry_station, :exit_station
  PENALTY_FARE = 6
  MIN_FARE = 1

  def initialize(entry_station: nil)
    @entry_station = entry_station
    @exit_station = nil
    @complete = false
  end

  def finish(exit_station)
    exit(exit_station)
    complete if entry_station && exit_station
    self
  end

  def complete?
    @complete
  end

  def fare
    return PENALTY_FARE unless complete?
    calculate_fare
  end

  private

  def exit(exit_station)
    @exit_station = exit_station
  end

  def complete
    @complete = true
  end

  def calculate_fare
    enter_zone = @entry_station.zone
    exit_zone = @exit_station.zone
    (enter_zone - exit_zone).abs + 1
  end
end
